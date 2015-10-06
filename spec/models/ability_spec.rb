require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject { ability }
  let(:ability) { Ability.new(user) }

  describe 'abilities of guest' do
    let(:user) { nil }

    context 'for projects' do
      let(:project) { create(:project) }

      it { expect(ability).not_to be_able_to(:read, project) }
      it { expect(ability).not_to be_able_to(:create, Project.new) }
      it { expect(ability).not_to be_able_to(:update, project) }
      it { expect(ability).not_to be_able_to(:destroy, project) }
    end

    context 'for tasks' do
      let(:task) { create(:task) }

      it { expect(ability).not_to be_able_to(:read, task) }
      it { expect(ability).not_to be_able_to(:create, Task.new) }
      it { expect(ability).not_to be_able_to(:update, task) }
      it { expect(ability).not_to be_able_to(:destroy, task) }
    end
  end

  describe 'abilities of user' do
    let(:user) { create(:user) }

    context 'for projects' do
      let(:project) { create(:project, user: user) }

      it { expect(ability).to be_able_to(:read, project) }
      it { expect(ability).to be_able_to(:create, Project) }
      it { expect(ability).to be_able_to(:update, project) }
      it { expect(ability).to be_able_to(:destroy, project) }
    end

    context 'for tasks' do
      let!(:task) { create(:task, project: create(:project, user: user)) }

      it { expect(ability).to be_able_to(:read, task) }
      it { expect(ability).to be_able_to(:create, Task) }
      it { expect(ability).to be_able_to(:update, task) }
      it { expect(ability).to be_able_to(:destroy, task) }
    end
  end
end