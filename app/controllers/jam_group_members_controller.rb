class JamGroupMembersController < ApplicationController
  before_action :set_jam_group_member, only: [:accept_invite, :reject_invite, :show, :edit, :update, :destroy]
  before_action :authenticate_user!
  layout :resolve_layout

  # GET /jam_group_members
  # GET /jam_group_members.json
  def index
    @jam_group_members = JamGroupMember.all
  end

  def list_pending
    @invites = JamGroupMember.where(profile: current_user.profile).where(status: :pending).all
    render "list_invites"
  end

  def accept_invite
    @jam_group_member.status = :joined 
    @jam_group_member.save

    respond_to do |format|
      format.html { redirect_to jam_group_path(@jam_group_member.jam_group), notice: "Joined Jam Group '#{@jam_group_member.jam_group.name}'" }
      format.json { render status: :ok }
    end
  end

  def reject_invite
    @jam_group_member.status = :rejected 
    @jam_group_member.save

    respond_to do |format|
      format.html { redirect_to jam_group_members_list_pending_path, notice: "Rejected Jam Group invitation for '#{@jam_group_member.jam_group.name}'" }
      format.html { redirect_to jam_group_path(@jam_group_member.jam_group), notice: "Rejected Jam Group invitation for '#{@jam_group_member.jam_group.name}'" }
      format.json { render status: :ok }
    end
  end

  # GET /jam_group_members/1
  # GET /jam_group_members/1.json
  def show
  end

  # GET /jam_group_members/new
  def new
    @jam_group_member = JamGroupMember.new
  end

  # GET /jam_group_members/1/edit
  def edit
  end

  # POST /jam_group_members
  # POST /jam_group_members.json
  def create
    #@jam_group_member = JamGroupMember.new(jam_group_member_params)
    if params[:jam_group] != nil && params[:profile] != nil
      @jam_group_member = JamGroupMember.new(profile_id: params[:profile], jam_group_id: params[:jam_group])
      @jam_group_member.invited_by = current_user.profile

      #if params[:invited_by] != nil
      #  @jam_group_member.invited_by = params[:invited_by]
      #else
      #  @jam_group_member.invited_by = params[:profile]
      #end

      respond_to do |format|
        if @jam_group_member.save
          format.html { redirect_to JamGroup.find(params[:jam_group]), notice: 'Jam group member was successfully invited.' }
          format.json { render :show, status: :created, location: @jam_group_member }
        else
          format.html { redirect_to JamGroup.find(params[:jam_group]) }
          format.json { render json: @jam_group_member.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to jam_groups_url }
        format.json { render json: {error: "Invalid Request"}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jam_group_members/1
  # PATCH/PUT /jam_group_members/1.json
  def update
    respond_to do |format|
      if @jam_group_member.update(jam_group_member_params)
        format.html { redirect_to @jam_group_member, notice: 'Jam group member was successfully updated.' }
        format.json { render :show, status: :ok, location: @jam_group_member }
      else
        format.html { render :edit }
        format.json { render json: @jam_group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jam_group_members/1
  # DELETE /jam_group_members/1.json
  def destroy
    @jam_group_member.destroy
    respond_to do |format|
      format.html { redirect_to jam_group_members_url, notice: 'Jam group member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jam_group_member
      if params[:id] != nil
        @jam_group_member = JamGroupMember.find(params[:id])
      elsif params[:jam_group_member_id] != nil
        @jam_group_member = JamGroupMember.find(params[:jam_group_member_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jam_group_member_params
      params.require(:jam_group_member).permit(:jam_group, :profile, :invited_by)
    end


    def resolve_layout
      case action_name
      when "list_pending"
        "jam_groups"
      else
        "application"
      end
    end
end
