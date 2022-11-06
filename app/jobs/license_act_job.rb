class LicenseActJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @licenses = License.where(state:"ok")
    @licenses = License.all
    @licenses.each do |l|
      if (l.expire.month == Time.now.month+3)
        l.state="toexpire"
      else
        if (l.expire.month == Time.now.month && l.expire.day == Time.now.day)
          l.state="expired"
        end
      end
      l.save
    end
  end
end