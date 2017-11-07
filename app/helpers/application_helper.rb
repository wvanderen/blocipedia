module ApplicationHelper
    def form_group_tag(errors, &block)
        css_class = 'form_group'
        css_class << 'has-error' if errors.any?
        content_tag :div, capture(&block), class: css_class
    end
    
    def is_premium?
        true if current_user && current_user.premium?
    end
    
    def is_standard?
        true if current_user && current_user.standard?
    end
end
