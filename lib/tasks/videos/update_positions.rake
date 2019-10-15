namespace :videos do
  desc "Videos with nil positions are replaced with valid positions"
  task :update_positions do
    Video.not_positioned.each { |video| video.update_placement }
  end
end
