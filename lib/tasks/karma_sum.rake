task :compute_karma_sum => :environment do
  User.all.each do |u|
    u.calculate_karma_sum
    puts "#{u.id}) #{u.karma_sum}"
  end
end
