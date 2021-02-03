class Organization < ApplicationRecord
  belongs_to :organization_type
  belongs_to :organization
  has_many :organizations
  has_many :organization_roles
  has_many :team_members, through: :organization_roles
  has_many :metrics
  has_many :targets
  has_many :organization_metric_types
  has_many :metric_types, through: :organization_metric_types

  def all_org_members
    subtree = self.class.tree_sql_for(self)
    TeamMember.where("organization_id IN (#{subtree})")
  end

  def all_metrics
    subtree = self.class.tree_sql_for(self)
    Metric.where("organization_id IN (#{subtree})")
  end

  def descendants
    self_and_descendants - [self]
  end

  def self_and_descendants
    self.class.tree_for(self)
  end

  def self.tree_for(instance)
    where("#{table_name}.id IN (#{tree_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.tree_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(id) AS (
        SELECT id
        FROM #{table_name}
        WHERE id = #{instance.id}
      UNION ALL
        SELECT #{table_name}.id
        FROM search_tree
        JOIN #{table_name} ON #{table_name}.organization_id = search_tree.id
      )
      SELECT id FROM search_tree
    SQL
  end
end
