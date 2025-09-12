using Android.App;
using Android.Content;
using Android.OS;
using AndroidX.Core.App;

namespace PriceTrackerApp.Platforms.Android
{
    [Service]
    [IntentFilter(new[] { "com.google.firebase.MESSAGING_EVENT" })]
    public class FirebaseMessageService : Service
    {
        public override void OnCreate()
        {
            base.OnCreate();

            if (Build.VERSION.SdkInt >= BuildVersionCodes.O)
            {
                var channel = new NotificationChannel("default", "General Notifications", NotificationImportance.Default)
                {
                    Description = "General notifications for the app"
                };

                var notificationManager = (NotificationManager)GetSystemService(NotificationService);
                notificationManager.CreateNotificationChannel(channel);
            }
        }

        public override IBinder? OnBind(Intent? intent)
        {
            return null; // Cambiado para evitar advertencias de referencia nula
        }

        private void SendNotification(string? title, string? body)
        {
            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(body))
            {
                Console.WriteLine("Notification title or body is null or empty.");
                return;
            }

            var notificationManager = NotificationManagerCompat.From(this);

            if (notificationManager == null)
            {
                Console.WriteLine("NotificationManager is null.");
                return;
            }

            var notification = new NotificationCompat.Builder(this, "default")
                .SetContentTitle(title ?? string.Empty)
                .SetContentText(body ?? string.Empty)
                .SetSmallIcon(Resource.Drawable.ic_notification)
                .SetPriority((int)NotificationPriority.Default)
                .Build();

            notificationManager.Notify(0, notification);
        }
    }
}
