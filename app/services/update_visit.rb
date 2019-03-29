class UpdateVisit < ServiceBase
  def initialize(visit_info, new_content)
    @visit_info = visit_info
    @new_content = new_content
  end

  def call
    @visit_info.with_lock do
      @visit_info.update_visit(@new_content)
      @visit_info.save
    end
  end
end
