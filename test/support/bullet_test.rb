module BulletTest
  extend ActiveSupport::Concern

  included do
    setup :setup_bullet
    teardown :teardown_bullet
  end

  def setup_bullet
    Bullet.start_request if Bullet.enable?
  end

  def teardown_bullet
    if Bullet.enable?
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end
end
