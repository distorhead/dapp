module Dapp
  module Dimg
    module Build
      module Stage
        class GALatestPatch < GABase
          def initialize(dimg, next_stage)
            @prev_stage = AfterSetupArtifact.new(dimg, self)
            super
          end

          def dependencies_stage
            nil
          end

          def dependencies
            @dependencies ||= [commit_list, git_artifacts_dev_patch_hashes]
          end

          def layer_commit(git_artifact)
            commits[git_artifact] ||= git_artifact.latest_commit
          end

          def empty?
            dimg.git_artifacts.empty? || dependencies_empty?
          end

          private

          def commit_list
            dimg.git_artifacts.map { |git_artifact| layer_commit(git_artifact) }
          end

          def git_artifacts_dev_patch_hashes
            dimg.git_artifacts.map(&:dev_patch_hash)
          end
        end # GALatestPatch
      end # Stage
    end # Build
  end # Dimg
end # Dapp
