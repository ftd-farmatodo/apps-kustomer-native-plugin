package com.example.kustomer_native_plugin

data class KustomerConfig(
        val apiKey: String,
        val brandId: String,
        val email: String?,
        val initialMessage: String,
        val phone: String?,
        val token: String?,
) {
    companion object {
        fun fromMap(map: Map<String, Any?>) = object {
            val apiKey by map
            val brandId by map
            val email by map
            val initialMessage by map
            val phone by map
            val token by map

            val data = KustomerConfig(
                    apiKey = apiKey as? String ?: "",
                    brandId = brandId as? String ?: "",
                    email = email as? String,
                    initialMessage = initialMessage as? String ?: "",
                    phone = phone as? String,
                    token = token as? String,
            )
        }.data
    }
}
