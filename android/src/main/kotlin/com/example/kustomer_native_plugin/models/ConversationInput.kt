package com.example.kustomer_native_plugin.models


import android.os.Parcelable
import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize
import kotlinx.parcelize.RawValue
import java.io.Serializable

@Parcelize
class ConversationInput(
    @SerializedName("initialMessage")
    @Expose
    val initialMessage: String? = "",
    @SerializedName("title")
    @Expose
    val title: String? = "",
    @SerializedName("map")
    @Expose
    val map: @RawValue HashMap<String,Any>?,
) : Serializable, Parcelable

