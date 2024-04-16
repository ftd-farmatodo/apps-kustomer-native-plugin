package com.example.kustomer_native_plugin.models

import android.os.Parcelable
import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize
import kotlinx.parcelize.RawValue
import java.io.Serializable

@Parcelize
class DescribeCustomer(@SerializedName("email")
                        @Expose
                        val email: String,
                       @SerializedName("phone")
                       @Expose
                       val phone: String,
                       @SerializedName("custom")
                        @Expose
                        val custom: @RawValue Map<String,Any>?,) : Serializable, Parcelable
