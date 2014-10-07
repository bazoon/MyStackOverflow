class ChangeVoteableIdForVote < ActiveRecord::Migration
  def change
    rename_column :votes, :votable_id, :voteable_id
  end
end
