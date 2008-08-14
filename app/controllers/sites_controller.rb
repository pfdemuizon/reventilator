class SitesController < ApplicationController
  before_filter :require_login

  # GET new_site_url
  def new
    @site = Site.new
  end

  # POST site_url
  def create
    @site = Site.create!(params[:site])
    @site.save!
  rescue
    render :action => 'new'
  end

  # GET site_url
  def show
    @site = Site.find(params[:id])
  end

  # GET edit_site_url
  def edit
    @site = Site.find(params[:id)
  end

  # PUT site_url
  def update
    @site = Site.find(params[:site])
    @site.save!
  rescue
    render :action => 'edit'
  end

  # DELETE site_url
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
  end
end
