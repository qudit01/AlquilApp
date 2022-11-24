class LicenseActJob < ApplicationJob
  queue_as :default

  def perform
    @licenses = License.where(state:"ok", state:"toexpire")
    @licenses.each do |l|
      if (l.expire.month == Time.now.month+1 || l.expire.month == Time.now.month+2 || (l.expire.month == Time.now.month && l.expire.day != Time.now.day))
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