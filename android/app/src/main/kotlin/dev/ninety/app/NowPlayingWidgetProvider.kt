package dev.ninety.app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/// Home-screen widget reflecting current audio. Tap opens the Quran screen.
class NowPlayingWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_now_playing).apply {
                val active = widgetData.getBoolean("np_active", false)
                val title = widgetData.getString("np_title", "") ?: ""

                setTextViewText(
                    R.id.widget_np_status,
                    if (active) "Now playing" else "Quran audio"
                )
                setTextViewText(
                    R.id.widget_np_title,
                    if (active && title.isNotEmpty()) title else "Tap to listen"
                )

                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("homeWidget://quran")
                )
                setOnClickPendingIntent(R.id.widget_np_root, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
