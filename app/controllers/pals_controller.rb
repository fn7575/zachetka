class PalsController < ApplicationController
  before_action :authenticate_user!
  before_action :parse_params, only: :output
  before_action :set_locale

  def input
    @phrase = Pal.connection.execute('SELECT  "pals"."count" FROM "pals" ORDER BY RANDOM() LIMIT 1')

    if !@phrase.empty?
      @phrase = @phrase[0][0]
    end
  end

  def all
    @res = Pal.all
    render xml: @res.as_json.to_xml
  end

  def showall
    @res = Pal.all.to_a
  end

  def edit_article
    @res = Pal.find_by(count: params[:text])

    if @res.author != current_user.email
      abort('Критическая ошибка!')
    end

    if !@res.new_record? && !params[:article].empty? && !params[:photo_link].empty? && !params[:sdr].empty?
      @res.update(res: params[:article])
      @res.update(photo: params[:photo_link])
      @res.update(shortDesc: params[:sdr])
      @status = true
    else
      @status = false
    end

    respond_to do |format|
      format.html
    end
  end

  def delete_article
    @res = Pal.find_by(count: params[:text])

    if @res.author != current_user.email
      abort('Критическая ошибка!')
    end

    if @res.new_record?
      @status = false
    else
      @res.destroy
      @status = true
    end

    respond_to do |format|
      format.html
    end
  end

  def create_article
    @pal = Pal.find_or_initialize_by(count: params[:text])
    if @pal.new_record? && !params[:article].empty? && !params[:photo_link].empty? && !params[:sdr].empty?
      @pal.count = params[:text]
      @pal.res = params[:article]
      @pal.author = current_user.email
      @pal.photo = params[:photo_link]
      @pal.shortDesc = params[:sdr]
      @pal.save

      respond_to do |format|
        format.html
      end
    end
  end

  def output
    if params[:getrandarticle]
      @text = Pal.connection.execute('SELECT  "pals"."count" FROM "pals" ORDER BY RANDOM() LIMIT 1')

      if !@text.empty?
        @text = @text[0][0]
      end
    end

    @pal = Pal.find_or_initialize_by(count: @text)
    @pal.new_record? ? @status = 'no-content' : @status = 'ok'

    respond_to do |format|
      format.html
    end
  end

  protected

  def parse_params
    @text = params[:text]
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
