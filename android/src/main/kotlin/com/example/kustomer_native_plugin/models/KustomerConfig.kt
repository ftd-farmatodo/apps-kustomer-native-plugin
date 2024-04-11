package com.example.kustomer_native_plugin.models

import android.os.Parcelable
import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize
import java.io.Serializable

@Parcelize
class KustomerConfig(
    @SerializedName("brandId")
    @Expose
    val brandId: String = "",
    @SerializedName("apiKey")
    @Expose
    val apiKey: String = "",
): Serializable, Parcelable




