package com.example.native_channel.plugin


import NotificationApi
import NotificationPermissionStatus
import android.app.Activity
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import android.os.Build

class NotificationApiImpl(private  val  context: Context) : NotificationApi {

    private val channelId = "my_channel_id"
    private val notificationId = 1

    init {
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "My Channel"
            val descriptionText = "Channel for displaying notifications"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText
            }
            val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    override fun checkNotificationPermission(): NotificationPermissionStatus {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
            val manager : NotificationManagerCompat = NotificationManagerCompat.from(context)
            val  isGranted : Boolean = manager.areNotificationsEnabled()
            if (isGranted) {
                return NotificationPermissionStatus.GRANTED


            }
            return NotificationPermissionStatus.DENIED
        }
        return  NotificationPermissionStatus.NOT_DETERMINED
    }

    override fun requestPermission(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val activity = context as Activity
            val permission = android.Manifest.permission.POST_NOTIFICATIONS
            val hasPermission = ContextCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED

            if (!hasPermission) {
                ActivityCompat.requestPermissions(activity, arrayOf(permission), 123)
                return false
            } else {
                return true
            }
        } else {
            // For devices below Android 13, notifications are enabled by default
            return true
        }
    }

    override fun triggerNotification(title: String, message: String) {
        // Check if the app has notification permission
        val hasNotificationPermission = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ContextCompat.checkSelfPermission(
                context,
                android.Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            // For devices below Android 13, notifications are enabled by default
            true
        }

        if (!hasNotificationPermission) {
            // Permission not granted, handle accordingly
            requestPermission()
            return
        }

        // Permission granted, proceed to show the notification
        val notificationBuilder = NotificationCompat.Builder(context, channelId)
            .setSmallIcon(android.R.drawable.ic_dialog_info) // Use your app's icon here
            .setContentTitle(title)
            .setContentText(message)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)

        try {
            with(NotificationManagerCompat.from(context)) {
                notify(notificationId, notificationBuilder.build())
            }
        } catch (e: SecurityException) {
            // Handle the SecurityException (e.g., log the error or notify the user)
            println("Failed to show notification: ${e.message}")
        }
    }
}