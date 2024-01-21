This space is to write down code that can be used in a project.

```
class User < ApplicationRecord
  has_many :interactions
  has_many :coaches, through: :interactions

  def last_coach
    coaches.order('interactions.updated_at DESC').first
  end
end
```