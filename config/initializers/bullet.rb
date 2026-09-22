return unless defined?(Bullet)

Rails.application.configure do
  config.after_initialize do
    Bullet.enable        = true
    Bullet.bullet_logger = true
    Bullet.rails_logger  = true

    Bullet.add_safelist type: :n_plus_one_query, class_name: "ActiveStorage::Attachment", association: :blob
    Bullet.add_safelist type: :unused_eager_loading, class_name: "ActiveStorage::Blob", association: :variant_records
    Bullet.add_safelist type: :unused_eager_loading, class_name: "ActiveStorage::Blob", association: :preview_image_attachment
  end
end
