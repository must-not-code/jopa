ActiveAdmin.register Post do
  permit_params :title, :content, :published_at

  index do
    column :id
    column :title
    column :user
    column :published_at
    column :created_at
    column :updated_at

    actions
  end
  show do
    attributes_table do
      row :id
      row :user
      row :title
      row :game
      row (:content) {|foobar| foobar.content.html_safe if foobar.content}
      row :published_at
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :game
      f.input :content
      f.input :published_at
    end

    f.actions
  end

  member_action :publish, method: :get do
    resource.update(published_at: Time.now)
    redirect_to resource_path, notice: 'Published!'
  end

  action_item only: :edit do
    unless resource.published_at
      link_to 'Publish', 'publish'
    end
  end
end