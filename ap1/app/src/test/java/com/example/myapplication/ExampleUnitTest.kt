package com.example.myapplication

import android.view.View
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario.launch
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertNotNull
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.annotation.Config

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
@Config(sdk = [28])
class ExampleUnitTest {
    @Test
    fun testActivity() {
        val actScenario = launch(MainActivity::class.java)
        actScenario.moveToState(Lifecycle.State.RESUMED).onActivity {
            assertNotNull("Asset should not be null",it.findViewById<View>(R.id.text_view))
        }
    }
}
