# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "User" do
          li link_to('Users', admin_users_path)
        end
      end

      column do
        panel "Posts" do
          li link_to('Posts', admin_posts_path)
        end
      end

      column do
        panel "Users comments" do
          li link_to('Users comments', admin_post_comments_path)
        end
      end
    end
  end
end
