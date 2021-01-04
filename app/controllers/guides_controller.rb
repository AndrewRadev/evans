class GuidesController < ApplicationController
  def tasks
    render "guides/tasks/#{Language.language}"
  end

  def challenges
    render "guides/challenges/#{Language.language}"
  end

  def projects
    render "guides/projects/#{Language.language}"
  end
end
