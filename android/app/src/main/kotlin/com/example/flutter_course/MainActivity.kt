package com.example.flutter_course

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory


class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setApiKey("3abea75a-bb45-43a2-a753-d97ebc4817da")
    super.configureFlutterEngine(flutterEngine)
  }
}

/* 
import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setApiKey("3abea75a-bb45-43a2-a753-d97ebc4817da")
  }
}
*/