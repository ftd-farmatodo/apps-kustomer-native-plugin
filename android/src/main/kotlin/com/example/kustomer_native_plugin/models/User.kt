package com.example.kustomerchat.ui.models

import android.os.Parcelable
import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName
import kotlinx.android.parcel.Parcelize
import java.io.Serializable

@Parcelize
 class User(
    @SerializedName("firstName")
    @Expose
    val firstName: String = "",
    @SerializedName("lastName")
    @Expose
    val lastName: String = "",
    @SerializedName("email")
    @Expose
     val email: String = "",
    @SerializedName("phone")
    @Expose
    val phone: String = "",
    @SerializedName("token")
    @Expose
    val token: String = "",
    @SerializedName("documentNumber")
    @Expose
    val documentNumber: String = "",

 ): Serializable, Parcelable
