require 'rails_helper'

shared_examples_for "votable" do
  it { should have_many(:votes) }

  context "votes" do
    let(:user) { create(:user) }
    subject { create(described_class, user: user) }

    it "vote up" do
      do_vote("up")
      expect(subject.rating).to eq(1)
      expect(subject.user.rating).to eq(0.5)
    end

    it "vote down" do
      do_vote("down")
      expect(subject.rating).to eq(-1)
      expect(subject.user.rating).to eq(-0.5)
    end

    it "unvote" do
      do_vote("down")
      subject.unvote(user)
      expect(subject.rating).to eq(0)
      expect(subject.user.rating).to eq(0)
    end

    it "voted_for_by?" do
      val = subject.voted_for_by?(user)
      expect(val).to be false
      do_vote("down")
      val = subject.voted_for_by?(user)
      expect(subject.rating).to eq(-1)
      expect(subject.user.rating).to eq(-0.5)
    end

    it "author of vote?" do
      do_vote("down")
      expect(subject.author_of_vote?(user)).to be true
    end

    def do_vote(vote)
      subject.send("vote", user, { votable_id: subject.id, votable_type: "subject", value: vote })
    end
  end
end
