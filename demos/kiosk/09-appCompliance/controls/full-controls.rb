# encoding: UTF-8

control "habitat.installed" do
  title "Ensure habitat is installed"
  desc  ""
  impact 1.0

  describe file('/hab/sup/default/MEMBER_ID') do
    it { should exist }
  end

end


control "kiosk_cart.installed" do
  title "Ensure kiosk_cart is installed"
  desc  ""
  impact 1.0

  describe file('/hab/svc/kiosk_cart/PID') do
    it { should exist }
  end

end


control "kiosk_inventory.installed" do
  title "Ensure kiosk_inventory is installed"
  desc  ""
  impact 1.0

  describe file('/hab/svc/kiosk_inventory/PID') do
    it { should exist }
  end

end



control "kiosk_proxy.installed" do
  title "Ensure kiosk_proxy is installed"
  desc  ""
  impact 1.0

  describe file('/hab/svc/kiosk_proxy/PID') do
    it { should exist }
  end

end


control "kiosk_ui.installed" do
  title "Ensure kiosk_ui is installed"
  desc  ""
  impact 1.0

  describe file('/hab/svc/kiosk_ui/PID') do
    it { should exist }
  end

end


control "kiosk_meta.installed" do
  title "Ensure kiosk_meta is installed"
  desc  ""
  impact 1.0

  describe file('/hab/svc/kiosk_meta/PID') do
    it { should exist }
  end

end

control "kiosk_store.installed" do
  title "Ensure kiosk_store is installed"
  desc  ""
  impact 1.0

  describe file('/hab/svc/kiosk_store/PID') do
    it { should exist }
  end

end

