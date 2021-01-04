require 'spec_helper'

describe GuidesController do
  describe "GET tasks" do
    it "renders the tasks guide for the current language" do
      allow(Language).to receive(:language).and_return('clojure')
      get :tasks
      expect(response).to render_template 'guides/tasks/clojure'
    end
  end

  describe "GET projects" do
    it "renders the projects guide for the current language" do
      allow(Language).to receive(:language).and_return('rust')
      get :projects
      expect(response).to render_template 'guides/projects/rust'
    end
  end

  describe "GET challenges" do
    it "renders the projects guide for the current language" do
      allow(Language).to receive(:language).and_return('rust')
      get :challenges
      expect(response).to render_template 'guides/challenges/rust'
    end
  end
end
