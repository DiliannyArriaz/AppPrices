package crc64c5191b4ba6c38a70;


public class FirebaseMessageService
	extends com.google.firebase.messaging.FirebaseMessagingService
	implements
		mono.android.IGCUserPeer
{
/** @hide */
	public static final String __md_methods;
	static {
		__md_methods = 
			"n_onMessageReceived:(Lcom/google/firebase/messaging/RemoteMessage;)V:GetOnMessageReceived_Lcom_google_firebase_messaging_RemoteMessage_Handler\n" +
			"n_onCreate:()V:GetOnCreateHandler\n" +
			"";
		mono.android.Runtime.register ("PriceTrackerApp.Platforms.Android.FirebaseMessageService, PriceTrackerApp", FirebaseMessageService.class, __md_methods);
	}

	public FirebaseMessageService ()
	{
		super ();
		if (getClass () == FirebaseMessageService.class) {
			mono.android.TypeManager.Activate ("PriceTrackerApp.Platforms.Android.FirebaseMessageService, PriceTrackerApp", "", this, new java.lang.Object[] {  });
		}
	}

	public void onMessageReceived (com.google.firebase.messaging.RemoteMessage p0)
	{
		n_onMessageReceived (p0);
	}

	private native void n_onMessageReceived (com.google.firebase.messaging.RemoteMessage p0);

	public void onCreate ()
	{
		n_onCreate ();
	}

	private native void n_onCreate ();

	private java.util.ArrayList refList;
	public void monodroidAddReference (java.lang.Object obj)
	{
		if (refList == null)
			refList = new java.util.ArrayList ();
		refList.add (obj);
	}

	public void monodroidClearReferences ()
	{
		if (refList != null)
			refList.clear ();
	}
}
