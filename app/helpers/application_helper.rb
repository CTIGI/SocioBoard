module ApplicationHelper
  def footer_actions(index_path)
    actions = ""
    actions << (
      link_to "", class: "btn-submit btn btn-success btn-icon", data: { toggle: "tooltip", placement: "top", "original-title": t("app.save") } do
        fa_icon("check")
      end
    )

    actions << (
      link_to index_path, class: "btn bg-gray btn-icon btn-back", data: { toggle: "tooltip", placement: "top", "original-title": t("app.back") } do
        fa_icon("mail-reply")
      end
    )

    raw actions
  end

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

  def date_input(date)
    date.blank? ? "" : localize(date)
  end
end
