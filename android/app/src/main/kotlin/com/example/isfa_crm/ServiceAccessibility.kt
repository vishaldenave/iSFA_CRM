package com.example.isfa_crm

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
class ServiceAccessibility : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        LogUtils.info("Service Accessibility   "+event.action.toString())

    }
    override fun onInterrupt() {
        LogUtils.info("Service Accessibility  -- onInterrupt")

    }
    override fun onServiceConnected() {
        super.onServiceConnected()
        LogUtils.info("Service Accessibility  -- onServiceConnected")
    }
}