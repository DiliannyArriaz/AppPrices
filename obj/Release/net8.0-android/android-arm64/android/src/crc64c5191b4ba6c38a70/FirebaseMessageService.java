package crc64c5191b4ba6c38a70;


public class FirebaseMessageService
	extends android.app.Service
	implements
		mono.android.IGCUserPeer
{
/** @hide */
	public static final String __md_methods;
	static {
		__md_methods = 
			"n_onCreate:()V:GetOnCreateHandler\n" +
			"n_onBind:(Landroid/content/Intent;)Landroid/os/IBinder;:GetOnBind_Landroid_content_Intent_Handler\n" +
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


	public void onCreate ()
	{
		n_onCreate ();
	}

	private native void n_onCreate ();


	public android.os.IBinder onBind (android.content.Intent p0)
	{
		return n_onBind (p0);
	}

	private native android.os.IBinder n_onBind (android.content.Intent p0);

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
