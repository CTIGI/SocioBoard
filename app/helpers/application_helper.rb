module ApplicationHelper

  def menu_icon(path, icon, menu_name)
    link_to path, class: "link-sidebar hvr-bounce-to-right" do
      concat(fa_icon(icon, class: "icon-sidebar"))
      concat(
        content_tag(:span) do
          menu_name
        end
      )
    end
  end

  def show_field(field)
    field.blank? ? t("app.no_record") : field
  end
end
