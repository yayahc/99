package dev.ninety.app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/// Home-screen widget showing the "Name of the Day". Tap opens that name.
class NameOfDayWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_name_of_day).apply {
                val arabe = widgetData.getString("name_arabe", "") ?: ""
                val translit = widgetData.getString("name_transliteration", "") ?: ""
                val translation = widgetData.getString("name_translation", "") ?: ""
                val nameId = widgetData.getInt("name_id", 0)

                setTextViewText(R.id.widget_name_arabe, arabe)
                setTextViewText(R.id.widget_name_translit, translit)
                setTextViewText(R.id.widget_name_translation, translation)

                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("homeWidget://name?id=$nameId")
                )
                setOnClickPendingIntent(R.id.widget_name_root, pendingIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
