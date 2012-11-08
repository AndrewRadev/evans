require 'spec_helper'

describe ChallengeSubmission do
  describe "(construction)" do
    it "contains no code when the user has not submitted a solution" do
      user      = create :user
      challenge = create :challenge

      submission = ChallengeSubmission.for challenge, user

      submission.code.should be_blank
    end

    it "contains the code when the user has already submitted a solution" do
      user      = create :user
      challenge = create :challenge

      create :challenge_solution, user: user, challenge: challenge, code: 'solution code'

      submission = ChallengeSubmission.for challenge, user

      submission.code.should eq 'solution code'
    end
  end

  describe "(updating)" do
    let(:user) { create :user }
    let(:challenge) { create :challenge }
    let(:submission) { ChallengeSubmission.for challenge, user }

    it "creates a solution if one is not present" do
      expect do
        submission.update code: 'ruby code'
      end.to change(ChallengeSolution, :count).by(1)

      solution = ChallengeSolution.first
      solution.user.should eq user
      solution.challenge.should eq challenge
      solution.code.should eq 'ruby code'
    end

    it "updates the existing solution if one is present" do
      solution = create :challenge_solution, challenge: challenge, user: user, code: 'old code'

      submission.update code: 'new code'

      solution.reload.code.should eq 'new code'
    end
  end
end
