require 'json'
class Api::RobotsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_robot, only: [:show, :edit, :update, :destroy, :do_orders]

  # GET /robots
  # GET /robots.json
  def index
    @robots = Robot.all
  end

  # GET /robots/1
  # GET /robots/1.json
  def show
  end

  # GET /robots/new
  def new
    @robot = Robot.new
  end

  # GET /robots/1/edit
  def edit
  end

  # POST /robots
  # POST /robots.json
  def create
    @robot = Robot.new(robot_params)

    respond_to do |format|
      if @robot.save
        format.html { redirect_to @robot, notice: 'Robot was successfully created.' }
        format.json { render :show, status: :created, location: @robot }
      else
        format.html { render :new }
        format.json { render json: @robot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /robots/1
  # PATCH/PUT /robots/1.json
  def update
    respond_to do |format|
      if @robot.update(robot_params)
        format.html { redirect_to @robot, notice: 'Robot was successfully updated.' }
        format.json { render :show, status: :ok, location: @robot }
      else
        format.html { render :edit }
        format.json { render json: @robot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /robots/1
  # DELETE /robots/1.json
  def destroy
    @robot.destroy
    respond_to do |format|
      format.html { redirect_to robots_url, notice: 'Robot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def do_orders
    if params[:commands].present?
      message = check_robot_is_on_table? ? do_robot_move_by_cmd : "Robot will respond to your command if he is on the table, Please place him on the table first."
    else
      message = "You have given a wrong command. Please give a valid command."
    end
    render json: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_robot
      @robot = Robot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def robot_params
      params.require(:robot).permit(:table_cordinate, :is_placed)
    end

    def check_robot_is_on_table?
      if @robot.is_placed
        true
      elsif params[:commands][0] == "PLACE"
        @robot.update(is_placed: true)
        true
      else
        false
      end
    end

    def do_robot_move_by_cmd
      if params[:commands][1].class.to_s == "Integer" && params[:commands][2].class.to_s == "Integer"
        @x = params[:commands][1]
        @y = params[:commands][2]
        if check_cordinate_existance(@x, @y)
          @current_pos = "SOUTH"
          cmd_array = params[:commands][3..-1]
          @stop_x_val = false
          cmd_array.each do |value|
            if ["NORTH", "SOUTH", "EAST", "WEST", "MOVE", "LEFT", "RIGHT"].include?(value.to_s)
              if !["MOVE", "LEFT", "RIGHT"].include?(value.to_s)
                @current_pos = value.to_s
              else
                set_location_and_cordinates(@robot, value)
                if !check_cordinate_existance(@x, @y)
                  return "Please check the cordinates. Robot must not fall..."
                end
              end
            else
              return "Invalid command instruction found. Please input a valid command order."
            end
          end
          "location: [#{@x}, #{@y}, #{@current_pos}]"
        else
          "Please check the cordinates. Robot must not fall..."
        end
      else
        "Please give the cordinates correctly..."
      end
    end

    def set_location_and_cordinates(robot, value)
      if value == "MOVE"
        @current_pos = @current_pos
        move_cordinates
      elsif value == "LEFT"
        @stop_x_val = true
        find_the_location_by_left(@current_pos)
      elsif value == "RIGHT"
        @stop_x_val = true
        find_the_location_by_right(@current_pos)
      end
    end

    def move_cordinates
      if @stop_x_val == false
        @x = @x + 1
      else
        @y = @y + 1
      end
    end

    def find_the_location_by_left(crr_pos)
      if crr_pos == "NORTH"
        @current_pos = "WEST"
      elsif crr_pos == "EAST"
        @current_pos = "NORTH"
      elsif crr_pos == "WEST"
        @current_pos = "SOUTH"
      elsif crr_pos == "SOUTH"
        @current_pos = "EAST"
      end    
    end

    def find_the_location_by_right(crr_pos)
      if crr_pos == "NORTH"
        @current_pos = "EAST"
      elsif crr_pos == "EAST"
        @current_pos = "SOUTH"
      elsif crr_pos == "WEST"
        @current_pos = "NORTH"
      elsif crr_pos == "SOUTH"
        @current_pos = "WEST"
      end    
    end

    def check_cordinate_existance(x, y)
      r_cordinates = JSON.parse(@robot.table_cordinate)
      if ((x <=r_cordinates[0] && x >= 0) && (y <=r_cordinates[0] && y >= 0))
        true
      else
        false
      end
    end

end



