//usermanagement
const baseUrl = 'https://kovela.app/';

const TriggerOtp = 'usermgmt/auth/jtuserotp/trigger/otp?triggerOtp=false';
const SigninUrl = 'usermgmt/auth/login';
const SignupUrl = 'usermgmt/auth/jtuserotp/trigger/sign-up?triggerOtp=true';
const userDetails = 'usermgmt/user/userDetails';
const updateCurrentCustomerUrl = 'usermgmt/user/userDetails';
const deleteAccountUrl = 'usermgmt/user/skillrat';
const rolePostUrl = 'usermgmt/user/user';

//partner
const registrationUrl = 'delivery/api/partners';
const availabilityUrl = 'delivery/api/partners/availabilityByToken?available';
String fetchOrdersUrl(String partnerId, int page, int size) {
  return 'order/api/orders/by-partner?partnerId=$partnerId&status=&page=$page&size=$size';
}

const partnerDetailsUrl = 'delivery/api/partners/getPartner';
