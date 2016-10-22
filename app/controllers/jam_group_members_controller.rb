class JamGroupMembersController < ApplicationController
  before_action :set_jam_group_member, only: [:show, :edit, :update, :destroy]

  # GET /jam_group_members
  # GET /jam_group_members.json
  def index
    @jam_group_members = JamGroupMember.all
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
      if params[:invited_by] != nil
        @jam_group_member.invited_by = params[:invited_by]
      else
        @jam_group_member.invited_by = params[:profile]
      end

      respond_to do |format|
        if @jam_group_member.save
          format.html { redirect_to @jam_group_member, notice: 'Jam group member was successfully created.' }
          format.json { render :show, status: :created, location: @jam_group_member }
        else
          format.html { render :new }
          format.json { render json: @jam_group_member.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
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
      @jam_group_member = JamGroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jam_group_member_params
      params.require(:jam_group_member).permit(:jam_group, :profile, :invited_by)
    end
end
