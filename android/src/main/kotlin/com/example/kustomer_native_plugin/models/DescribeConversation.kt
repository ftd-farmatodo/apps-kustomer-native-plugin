package com.example.kustomer_native_plugin.models

import android.os.Parcelable
import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize
import kotlinx.parcelize.RawValue
import java.io.Serializable


    @Parcelize
    class DescribeConversation(@SerializedName("conversationId")
                           @Expose
                           val conversationId: String = "",
                           @SerializedName("map")
                           @Expose
                           val map: @RawValue Map<String,Any>?,) : Serializable, Parcelable

