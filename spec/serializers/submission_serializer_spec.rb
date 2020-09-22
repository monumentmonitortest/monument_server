require 'rails_helper'

describe SubmissionSerializer do
  let!(:submission) { create(:submission_with_insta_type)}
  

  subject { serialize(submission) }

  it { should include(:recordTaken => submission.record_taken) }
  it { should include(:ai_tags => []) }
  it { should include(:siteId => submission.site_id) }
  it { should include(:siteName => submission.site.name) }
  it { should include(:tags => submission.tag_list) }
  it { should include(:comment => submission.comment) }
  it { should include(:typeName => submission.type_name) }
  it { should include(:imageUrlSmall) }
  it { should include(:imageUrl) }
end