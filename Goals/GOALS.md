## Goals
- To create a comprehensive gym management system that streamlines the operations of fitness centers.
-  Goal 1 - A user can create an account and log in.
- Goal - Add GPT-4 for assisting user with workout routine, diet plan, etc.
- Goal 2 - A user can create a profile.
- Goal 3 - A user can create a workout routine with the help of Coach
- Goal 4 - A user can create a diet plan with the help of Nutritionist
- Goal 5 - A user can track their activities like running, cycling, etc. ( this can be done with the help of smart watch or mobile app)
- Goal 6 - A user can view their progress.
- Goal 7 - A user can view their membership details.
- Goal 8 - A user can view their payment history.
- Goal 9 - A user belong to a Business account.
- Goal 10 - A user can view there connected Business account profile.
- Goal 11 - A user with admin permission can create a Business account.
- Goal 12 - A user with admin permission can invite other users to join their Business account.
- Goal 13 - A user with admin permission can view the Business account details.
- Goal 14 - A user with admin permission can view the Business account payment history.
- Goal 15 - A user with admin permission can view the Business account membership details.
- Goal 16 - A user with admin permission can view the Business account staff details.
- Goal 17 - A user with admin permission can view the Business account member details.
- Goal 18 - A user with admin permission can view the Business account coach details.
- Goal 19 - A user with admin permission can view the Business account nutritionist details.
- Goal 20 - Business account can provide a membership to a user.
- Goal 21 - Business account can handle the payment of a user.
- Goal 22 - Business account can invite users with roles ie. staff, coach, nutritionist or normal user.
- Goal 23 - Business account can view the payment history of a user only for there business account membership.
- Goal 24 - Business account can view the membership details of a user only for there business account membership.
- Goal 25 - Business account can view the staff details of a user only for there business account membership.
- Goal 26 - Business account can create team for there users who have same goals or interests including coaches, nutritionists and staff and normal users.
- Goal 27 - Business account can view the team details
- Goal 28 - Business account can view the team members details
- Goal 29 - Business account can view the team members progress if shared by the user.
- Goal 30 - Business account can view the team members activities if shared by the user.
- Goal 31 - Business account can view the team members workout routine if shared by the user.
- Goal 32 - Business account can view the team members diet plan if shared by the user.
- Goal 33 - Business account users can fill attendance for entering the gym with qr code.
- Goal 34 - Business account users can view there attendance history.
- Goal 35 - Business account users can view there attendance details.
- Goal 36 - Business account or team account can create classes or sessions for team members.
- Goal 37 - Business account or team account can view the classes or sessions details.
- Goal 38 - Business account can send notification to user for any updates including classes/sessions, membership expiry, payment due, etc.
- Goal 39 - Business account can view the notification history.
- Goal 40 - Business account users can view the notification details.
- Goal 41 - Business account can create Blog for there users to share information.
- Goal 42 - super User can create a Blog as a app owner for all users.
- Goal 43 - Business account users can view blogs of there connected business account and super user.
- Goal 44 - User without business account can view blogs of super user.
- Goal 45 - user without business account can subscribe for membership to use there AI based features.

Features
Find the most recent coach intraction with user and show it on dashboard.
```
class User < ApplicationRecord
  has_many :interactions
  has_many :coaches, through: :interactions

  def last_coach
    coaches.order('interactions.updated_at DESC').first
  end
end
```

- etc will update more goals later.