class Api::V1::TextOperationsController < ApplicationController

  def run_commands
    commands = run_commands_params[:commands]&.split('|')

    # response =
    if commands.blank?
      response = { status: 'no_commands', message: 'No commands are provided.' }
    else
      begin
        result = TextProcessor::TextProcessor.new(commands,run_commands_params[:text]).process
        response = { status: 'ok', data: result }
      rescue TextProcessor::CommandError => ex
        response = { status: 'command_error', message: ex.message }
      rescue => ex
        response = { status: 'error', message: ex.message }
      end
    end

    render json: response
  end

  private

  def run_commands_params
    params.permit(:commands, :text)
  end
end