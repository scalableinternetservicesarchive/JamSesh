class JamGroupsController < ApplicationController
  protect_from_forgery prepend: true
  before_action :set_jam_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /jam_groups
  # GET /jam_groups.json
  def index
    if params[:all] == 'true'
      @jam_groups = JamGroup.all
    else
      @jam_groups = current_user.profile.jam_groups.all
    end
    render(:layout => 'layouts/jam_groups')
  end

  # GET /jam_groups/1
  # GET /jam_groups/1.json
  def show
  end

  # GET /jam_groups/new
  def new
    @jam_group = JamGroup.new
  end

  # GET /jam_groups/1/edit
  def edit
  end

  # POST /jam_groups
  # POST /jam_groups.json
  def create
    @jam_group = JamGroup.new(jam_group_params)

    respond_to do |format|
      if @jam_group.save
        jgm = JamGroupMember.new(
          profile: current_user.profile, 
          jam_group: @jam_group, 
          invited_by: current_user.profile, 
          status: :joined
        )
        jgm.save
        format.html { redirect_to @jam_group, notice: 'Jam group was successfully created.' }
        format.json { render :show, status: :created, location: @jam_group }
      else
        format.html { render :new }
        format.json { render json: @jam_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jam_groups/1
  # PATCH/PUT /jam_groups/1.json
  def update
    respond_to do |format|
      if @jam_group.update(jam_group_params)
        format.html { redirect_to @jam_group, notice: 'Jam group was successfully updated.' }
        format.json { render :show, status: :ok, location: @jam_group }
      else
        format.html { render :edit }
        format.json { render json: @jam_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jam_groups/1
  # DELETE /jam_groups/1.json
  def destroy
    destroy_group = false
    if params[:force_delete] == 'true'
      destroy_group = true
    end

    profile = current_user.profile
    if profile.jam_groups.all.include?(@jam_group)
      profile.jam_group_member.delete(JamGroupMember.where(profile: profile).where(jam_group: @jam_group).limit(1))
      if @jam_group.members.length == 0
        destroy_group = true
      end
    end

    if destroy_group
      @jam_group.destroy
      respond_to do |format|
        format.html { redirect_to jam_groups_url, notice: 'Jam group was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to jam_groups_url, notice: 'Successfully left the Jam group.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jam_group
      @jam_group = JamGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jam_group_params
      params.require(:jam_group).permit(:name, :image_url, :description)
    end
end
