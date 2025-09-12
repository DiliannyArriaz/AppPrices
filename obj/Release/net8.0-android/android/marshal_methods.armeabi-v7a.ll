; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [140 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [280 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 102
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 101
	i32 39109920, ; 2: Newtonsoft.Json.dll => 0x254c520 => 49
	i32 42639949, ; 3: System.Threading.Thread => 0x28aa24d => 129
	i32 52239042, ; 4: HtmlAgilityPack => 0x31d1ac2 => 35
	i32 67008169, ; 5: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 72070932, ; 6: Microsoft.Maui.Graphics.dll => 0x44bb714 => 48
	i32 117431740, ; 7: System.Runtime.InteropServices => 0x6ffddbc => 118
	i32 122350210, ; 8: System.Threading.Channels.dll => 0x74aea82 => 128
	i32 142721839, ; 9: System.Net.WebHeaderCollection => 0x881c32f => 108
	i32 165246403, ; 10: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 55
	i32 182336117, ; 11: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 73
	i32 195452805, ; 12: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 13: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 14: System.ComponentModel => 0xc38ff48 => 88
	i32 230752869, ; 15: Microsoft.CSharp.dll => 0xdc10265 => 81
	i32 246610117, ; 16: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 116
	i32 280992041, ; 17: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 317674968, ; 18: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 19: Xamarin.AndroidX.Activity.dll => 0x13031348 => 51
	i32 336156722, ; 20: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 21: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 62
	i32 356389973, ; 22: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 375677976, ; 23: System.Net.ServicePoint.dll => 0x16646418 => 106
	i32 379916513, ; 24: System.Threading.Thread.dll => 0x16a510e1 => 129
	i32 385762202, ; 25: System.Memory.dll => 0x16fe439a => 99
	i32 395744057, ; 26: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 27: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 28: System.Collections => 0x1a61054f => 85
	i32 450948140, ; 29: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 61
	i32 459347974, ; 30: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 122
	i32 469710990, ; 31: System.dll => 0x1bff388e => 134
	i32 498788369, ; 32: System.ObjectModel => 0x1dbae811 => 111
	i32 500358224, ; 33: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 34: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 35: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 43
	i32 539058512, ; 36: Microsoft.Extensions.Logging => 0x20216150 => 40
	i32 592146354, ; 37: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 627609679, ; 38: Xamarin.AndroidX.CustomView => 0x2568904f => 59
	i32 627931235, ; 39: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 663517072, ; 40: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 74
	i32 672442732, ; 41: System.Collections.Concurrent => 0x2814a96c => 82
	i32 683518922, ; 42: System.Net.Security => 0x28bdabca => 105
	i32 688181140, ; 43: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 44: System.Xml.Linq.dll => 0x29293ff5 => 131
	i32 706645707, ; 45: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 46: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 47: System.Runtime.Loader.dll => 0x2b15ed29 => 119
	i32 759454413, ; 48: System.Net.Requests => 0x2d445acd => 104
	i32 775507847, ; 49: System.IO.Compression => 0x2e394f87 => 96
	i32 777317022, ; 50: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 51: Microsoft.Extensions.Options => 0x2f0980eb => 42
	i32 804715423, ; 52: System.Data.Common => 0x2ff6fb9f => 90
	i32 823281589, ; 53: System.Private.Uri.dll => 0x311247b5 => 112
	i32 830298997, ; 54: System.IO.Compression.Brotli => 0x317d5b75 => 95
	i32 904024072, ; 55: System.ComponentModel.Primitives.dll => 0x35e25008 => 86
	i32 926902833, ; 56: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 57: Newtonsoft.Json => 0x38f24a24 => 49
	i32 967690846, ; 58: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 62
	i32 975874589, ; 59: System.Xml.XDocument => 0x3a2aaa1d => 133
	i32 992768348, ; 60: System.Collections.dll => 0x3b2c715c => 85
	i32 1012816738, ; 61: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 72
	i32 1019214401, ; 62: System.Drawing => 0x3cbffa41 => 93
	i32 1028951442, ; 63: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 39
	i32 1029334545, ; 64: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 65: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 52
	i32 1036536393, ; 66: System.Drawing.Primitives.dll => 0x3dc84a49 => 92
	i32 1044663988, ; 67: System.Linq.Expressions.dll => 0x3e444eb4 => 97
	i32 1052210849, ; 68: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 64
	i32 1082857460, ; 69: System.ComponentModel.TypeConverter => 0x408b17f4 => 87
	i32 1084122840, ; 70: Xamarin.Kotlin.StdLib => 0x409e66d8 => 78
	i32 1098259244, ; 71: System => 0x41761b2c => 134
	i32 1118262833, ; 72: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1168523401, ; 73: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 74: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 69
	i32 1203215381, ; 75: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1234928153, ; 76: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 77: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1293217323, ; 78: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 60
	i32 1324164729, ; 79: System.Linq => 0x4eed2679 => 98
	i32 1373134921, ; 80: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 81: Xamarin.AndroidX.SavedState => 0x52114ed3 => 72
	i32 1406073936, ; 82: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 56
	i32 1408764838, ; 83: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 121
	i32 1430672901, ; 84: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1452070440, ; 85: System.Formats.Asn1.dll => 0x568cd628 => 94
	i32 1458022317, ; 86: System.Net.Security.dll => 0x56e7a7ad => 105
	i32 1461004990, ; 87: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 88: System.IO.Compression.dll => 0x57261233 => 96
	i32 1469204771, ; 89: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 53
	i32 1470490898, ; 90: Microsoft.Extensions.Primitives => 0x57a5e912 => 43
	i32 1480492111, ; 91: System.IO.Compression.Brotli.dll => 0x583e844f => 95
	i32 1493001747, ; 92: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 93: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 94: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 127
	i32 1551623176, ; 95: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1622152042, ; 96: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 66
	i32 1624863272, ; 97: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 76
	i32 1636350590, ; 98: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 58
	i32 1639515021, ; 99: System.Net.Http.dll => 0x61b9038d => 100
	i32 1639986890, ; 100: System.Text.RegularExpressions => 0x61c036ca => 127
	i32 1657153582, ; 101: System.Runtime => 0x62c6282e => 123
	i32 1658251792, ; 102: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 77
	i32 1677501392, ; 103: System.Net.Primitives.dll => 0x63fca3d0 => 103
	i32 1679769178, ; 104: System.Security.Cryptography => 0x641f3e5a => 124
	i32 1729485958, ; 105: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 54
	i32 1736233607, ; 106: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 107: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1763938596, ; 108: System.Diagnostics.TraceSource.dll => 0x69239124 => 91
	i32 1766324549, ; 109: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 73
	i32 1770582343, ; 110: Microsoft.Extensions.Logging.dll => 0x6988f147 => 40
	i32 1780572499, ; 111: Mono.Android.Runtime.dll => 0x6a216153 => 138
	i32 1782862114, ; 112: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 113: Xamarin.AndroidX.Fragment => 0x6a96652d => 61
	i32 1793755602, ; 114: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 115: Xamarin.AndroidX.Loader => 0x6bcd3296 => 66
	i32 1813058853, ; 116: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 78
	i32 1813201214, ; 117: Xamarin.Google.Android.Material => 0x6c13413e => 77
	i32 1818569960, ; 118: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 70
	i32 1824175904, ; 119: System.Text.Encoding.Extensions => 0x6cbab720 => 125
	i32 1824722060, ; 120: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 121
	i32 1828688058, ; 121: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 41
	i32 1842015223, ; 122: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 123: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 124: System.Linq.Expressions => 0x6ec71a65 => 97
	i32 1870277092, ; 125: System.Reflection.Primitives => 0x6f7a29e4 => 117
	i32 1875935024, ; 126: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1910275211, ; 127: System.Collections.NonGeneric.dll => 0x71dc7c8b => 83
	i32 1939592360, ; 128: System.Private.Xml.Linq => 0x739bd4a8 => 113
	i32 1968388702, ; 129: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 36
	i32 2003115576, ; 130: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 131: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 64
	i32 2025202353, ; 132: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 133: System.Private.Xml => 0x79eb68ee => 114
	i32 2055257422, ; 134: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 63
	i32 2066184531, ; 135: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 136: System.Diagnostics.TraceSource => 0x7b6f419e => 91
	i32 2079903147, ; 137: System.Runtime.dll => 0x7bf8cdab => 123
	i32 2090596640, ; 138: System.Numerics.Vectors => 0x7c9bf920 => 110
	i32 2127167465, ; 139: System.Console => 0x7ec9ffe9 => 89
	i32 2142473426, ; 140: System.Collections.Specialized => 0x7fb38cd2 => 84
	i32 2159891885, ; 141: Microsoft.Maui => 0x80bd55ad => 46
	i32 2169148018, ; 142: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 143: Microsoft.Extensions.Options.dll => 0x820d22b3 => 42
	i32 2192057212, ; 144: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 41
	i32 2193016926, ; 145: System.ObjectModel.dll => 0x82b6c85e => 111
	i32 2201107256, ; 146: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 79
	i32 2201231467, ; 147: System.Net.Http => 0x8334206b => 100
	i32 2207618523, ; 148: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2266799131, ; 149: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 37
	i32 2270573516, ; 150: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 151: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 71
	i32 2295906218, ; 152: System.Net.Sockets => 0x88d8bfaa => 107
	i32 2303942373, ; 153: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 154: System.Private.CoreLib.dll => 0x896b7878 => 136
	i32 2353062107, ; 155: System.Net.Primitives => 0x8c40e0db => 103
	i32 2368005991, ; 156: System.Xml.ReaderWriter.dll => 0x8d24e767 => 132
	i32 2371007202, ; 157: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 36
	i32 2395872292, ; 158: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 159: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 160: System.Console.dll => 0x912896e5 => 89
	i32 2458678730, ; 161: System.Net.Sockets.dll => 0x928c75ca => 107
	i32 2471841756, ; 162: netstandard.dll => 0x93554fdc => 135
	i32 2475788418, ; 163: Java.Interop.dll => 0x93918882 => 137
	i32 2480646305, ; 164: Microsoft.Maui.Controls => 0x93dba8a1 => 44
	i32 2484371297, ; 165: System.Net.ServicePoint => 0x94147f61 => 106
	i32 2538310050, ; 166: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 116
	i32 2550873716, ; 167: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 168: Microsoft.CSharp => 0x98ba5a04 => 81
	i32 2585220780, ; 169: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 125
	i32 2593496499, ; 170: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 171: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 79
	i32 2617129537, ; 172: System.Private.Xml.dll => 0x9bfe3a41 => 114
	i32 2620871830, ; 173: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 58
	i32 2626831493, ; 174: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2663698177, ; 175: System.Runtime.Loader => 0x9ec4cf01 => 119
	i32 2664396074, ; 176: System.Xml.XDocument.dll => 0x9ecf752a => 133
	i32 2665622720, ; 177: System.Drawing.Primitives => 0x9ee22cc0 => 92
	i32 2676780864, ; 178: System.Data.Common.dll => 0x9f8c6f40 => 90
	i32 2724373263, ; 179: System.Runtime.Numerics.dll => 0xa262a30f => 120
	i32 2732626843, ; 180: Xamarin.AndroidX.Activity => 0xa2e0939b => 51
	i32 2735172069, ; 181: System.Threading.Channels => 0xa30769e5 => 128
	i32 2737747696, ; 182: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 53
	i32 2752995522, ; 183: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 184: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 45
	i32 2764765095, ; 185: Microsoft.Maui.dll => 0xa4caf7a7 => 46
	i32 2778768386, ; 186: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 75
	i32 2785988530, ; 187: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 188: Microsoft.Maui.Graphics => 0xa7008e0b => 48
	i32 2806116107, ; 189: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 190: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 56
	i32 2831556043, ; 191: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2853208004, ; 192: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 75
	i32 2861189240, ; 193: Microsoft.Maui.Essentials => 0xaa8a4878 => 47
	i32 2909740682, ; 194: System.Private.CoreLib => 0xad6f1e8a => 136
	i32 2916838712, ; 195: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 76
	i32 2919462931, ; 196: System.Numerics.Vectors.dll => 0xae037813 => 110
	i32 2959614098, ; 197: System.ComponentModel.dll => 0xb0682092 => 88
	i32 2978675010, ; 198: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 60
	i32 3038032645, ; 199: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 200: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 67
	i32 3059408633, ; 201: Mono.Android.Runtime => 0xb65adef9 => 138
	i32 3059793426, ; 202: System.ComponentModel.Primitives => 0xb660be12 => 86
	i32 3077302341, ; 203: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3103600923, ; 204: System.Formats.Asn1 => 0xb8fd311b => 94
	i32 3159123045, ; 205: System.Reflection.Primitives.dll => 0xbc4c6465 => 117
	i32 3178803400, ; 206: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 68
	i32 3220365878, ; 207: System.Threading => 0xbff2e236 => 130
	i32 3258312781, ; 208: Xamarin.AndroidX.CardView => 0xc235e84d => 54
	i32 3305363605, ; 209: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 210: System.Net.Requests.dll => 0xc5b097e4 => 104
	i32 3317135071, ; 211: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 59
	i32 3346324047, ; 212: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 69
	i32 3357674450, ; 213: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 214: System.Text.Json => 0xc82afec1 => 126
	i32 3362522851, ; 215: Xamarin.AndroidX.Core => 0xc86c06e3 => 57
	i32 3366347497, ; 216: Java.Interop => 0xc8a662e9 => 137
	i32 3374999561, ; 217: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 71
	i32 3381016424, ; 218: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3428513518, ; 219: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 38
	i32 3430777524, ; 220: netstandard => 0xcc7d82b4 => 135
	i32 3463511458, ; 221: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3471940407, ; 222: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 87
	i32 3476120550, ; 223: Mono.Android => 0xcf3163e6 => 139
	i32 3479583265, ; 224: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 225: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 226: System.Text.Json.dll => 0xcfbaacae => 126
	i32 3509114376, ; 227: System.Xml.Linq => 0xd128d608 => 131
	i32 3580758918, ; 228: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3581607451, ; 229: PriceTrackerApp => 0xd57afe1b => 80
	i32 3608519521, ; 230: System.Linq.dll => 0xd715a361 => 98
	i32 3641597786, ; 231: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 63
	i32 3643446276, ; 232: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 233: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 68
	i32 3657292374, ; 234: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 37
	i32 3660523487, ; 235: System.Net.NetworkInformation => 0xda2f27df => 102
	i32 3672681054, ; 236: Mono.Android.dll => 0xdae8aa5e => 139
	i32 3697841164, ; 237: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3700866549, ; 238: System.Net.WebProxy.dll => 0xdc96bdf5 => 109
	i32 3724971120, ; 239: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 67
	i32 3732100267, ; 240: System.Net.NameResolution => 0xde7354ab => 101
	i32 3748608112, ; 241: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 50
	i32 3786282454, ; 242: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 55
	i32 3792276235, ; 243: System.Collections.NonGeneric => 0xe2098b0b => 83
	i32 3802395368, ; 244: System.Collections.Specialized.dll => 0xe2a3f2e8 => 84
	i32 3810220126, ; 245: HtmlAgilityPack.dll => 0xe31b585e => 35
	i32 3819260425, ; 246: System.Net.WebProxy => 0xe3a54a09 => 109
	i32 3823082795, ; 247: System.Security.Cryptography.dll => 0xe3df9d2b => 124
	i32 3841636137, ; 248: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 39
	i32 3849253459, ; 249: System.Runtime.InteropServices.dll => 0xe56ef253 => 118
	i32 3885497537, ; 250: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 108
	i32 3889960447, ; 251: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 252: System.Collections.Concurrent.dll => 0xe839deed => 82
	i32 3896760992, ; 253: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 57
	i32 3921031405, ; 254: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 74
	i32 3928044579, ; 255: System.Xml.ReaderWriter => 0xea213423 => 132
	i32 3931092270, ; 256: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 70
	i32 3955647286, ; 257: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 52
	i32 3980434154, ; 258: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 259: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4025784931, ; 260: System.Memory => 0xeff49a63 => 99
	i32 4046471985, ; 261: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 45
	i32 4054681211, ; 262: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 115
	i32 4068434129, ; 263: System.Private.Xml.Linq.dll => 0xf27f60d1 => 113
	i32 4073602200, ; 264: System.Threading.dll => 0xf2ce3c98 => 130
	i32 4094352644, ; 265: Microsoft.Maui.Essentials.dll => 0xf40add04 => 47
	i32 4099507663, ; 266: System.Drawing.dll => 0xf45985cf => 93
	i32 4100113165, ; 267: System.Private.Uri => 0xf462c30d => 112
	i32 4102112229, ; 268: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 269: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 270: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 38
	i32 4147896353, ; 271: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 115
	i32 4150914736, ; 272: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4181436372, ; 273: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 122
	i32 4182413190, ; 274: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 65
	i32 4213026141, ; 275: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 50
	i32 4259717024, ; 276: PriceTrackerApp.dll => 0xfde61fa0 => 80
	i32 4271975918, ; 277: Microsoft.Maui.Controls.dll => 0xfea12dee => 44
	i32 4274976490, ; 278: System.Runtime.Numerics => 0xfecef6ea => 120
	i32 4292120959 ; 279: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 65
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [280 x i32] [
	i32 102, ; 0
	i32 101, ; 1
	i32 49, ; 2
	i32 129, ; 3
	i32 35, ; 4
	i32 33, ; 5
	i32 48, ; 6
	i32 118, ; 7
	i32 128, ; 8
	i32 108, ; 9
	i32 55, ; 10
	i32 73, ; 11
	i32 30, ; 12
	i32 31, ; 13
	i32 88, ; 14
	i32 81, ; 15
	i32 116, ; 16
	i32 2, ; 17
	i32 30, ; 18
	i32 51, ; 19
	i32 15, ; 20
	i32 62, ; 21
	i32 14, ; 22
	i32 106, ; 23
	i32 129, ; 24
	i32 99, ; 25
	i32 34, ; 26
	i32 26, ; 27
	i32 85, ; 28
	i32 61, ; 29
	i32 122, ; 30
	i32 134, ; 31
	i32 111, ; 32
	i32 13, ; 33
	i32 7, ; 34
	i32 43, ; 35
	i32 40, ; 36
	i32 21, ; 37
	i32 59, ; 38
	i32 19, ; 39
	i32 74, ; 40
	i32 82, ; 41
	i32 105, ; 42
	i32 1, ; 43
	i32 131, ; 44
	i32 16, ; 45
	i32 4, ; 46
	i32 119, ; 47
	i32 104, ; 48
	i32 96, ; 49
	i32 25, ; 50
	i32 42, ; 51
	i32 90, ; 52
	i32 112, ; 53
	i32 95, ; 54
	i32 86, ; 55
	i32 28, ; 56
	i32 49, ; 57
	i32 62, ; 58
	i32 133, ; 59
	i32 85, ; 60
	i32 72, ; 61
	i32 93, ; 62
	i32 39, ; 63
	i32 3, ; 64
	i32 52, ; 65
	i32 92, ; 66
	i32 97, ; 67
	i32 64, ; 68
	i32 87, ; 69
	i32 78, ; 70
	i32 134, ; 71
	i32 16, ; 72
	i32 22, ; 73
	i32 69, ; 74
	i32 20, ; 75
	i32 18, ; 76
	i32 2, ; 77
	i32 60, ; 78
	i32 98, ; 79
	i32 32, ; 80
	i32 72, ; 81
	i32 56, ; 82
	i32 121, ; 83
	i32 0, ; 84
	i32 94, ; 85
	i32 105, ; 86
	i32 6, ; 87
	i32 96, ; 88
	i32 53, ; 89
	i32 43, ; 90
	i32 95, ; 91
	i32 10, ; 92
	i32 5, ; 93
	i32 127, ; 94
	i32 25, ; 95
	i32 66, ; 96
	i32 76, ; 97
	i32 58, ; 98
	i32 100, ; 99
	i32 127, ; 100
	i32 123, ; 101
	i32 77, ; 102
	i32 103, ; 103
	i32 124, ; 104
	i32 54, ; 105
	i32 23, ; 106
	i32 1, ; 107
	i32 91, ; 108
	i32 73, ; 109
	i32 40, ; 110
	i32 138, ; 111
	i32 17, ; 112
	i32 61, ; 113
	i32 9, ; 114
	i32 66, ; 115
	i32 78, ; 116
	i32 77, ; 117
	i32 70, ; 118
	i32 125, ; 119
	i32 121, ; 120
	i32 41, ; 121
	i32 29, ; 122
	i32 26, ; 123
	i32 97, ; 124
	i32 117, ; 125
	i32 8, ; 126
	i32 83, ; 127
	i32 113, ; 128
	i32 36, ; 129
	i32 5, ; 130
	i32 64, ; 131
	i32 0, ; 132
	i32 114, ; 133
	i32 63, ; 134
	i32 4, ; 135
	i32 91, ; 136
	i32 123, ; 137
	i32 110, ; 138
	i32 89, ; 139
	i32 84, ; 140
	i32 46, ; 141
	i32 12, ; 142
	i32 42, ; 143
	i32 41, ; 144
	i32 111, ; 145
	i32 79, ; 146
	i32 100, ; 147
	i32 14, ; 148
	i32 37, ; 149
	i32 8, ; 150
	i32 71, ; 151
	i32 107, ; 152
	i32 18, ; 153
	i32 136, ; 154
	i32 103, ; 155
	i32 132, ; 156
	i32 36, ; 157
	i32 13, ; 158
	i32 10, ; 159
	i32 89, ; 160
	i32 107, ; 161
	i32 135, ; 162
	i32 137, ; 163
	i32 44, ; 164
	i32 106, ; 165
	i32 116, ; 166
	i32 11, ; 167
	i32 81, ; 168
	i32 125, ; 169
	i32 20, ; 170
	i32 79, ; 171
	i32 114, ; 172
	i32 58, ; 173
	i32 15, ; 174
	i32 119, ; 175
	i32 133, ; 176
	i32 92, ; 177
	i32 90, ; 178
	i32 120, ; 179
	i32 51, ; 180
	i32 128, ; 181
	i32 53, ; 182
	i32 21, ; 183
	i32 45, ; 184
	i32 46, ; 185
	i32 75, ; 186
	i32 27, ; 187
	i32 48, ; 188
	i32 6, ; 189
	i32 56, ; 190
	i32 19, ; 191
	i32 75, ; 192
	i32 47, ; 193
	i32 136, ; 194
	i32 76, ; 195
	i32 110, ; 196
	i32 88, ; 197
	i32 60, ; 198
	i32 34, ; 199
	i32 67, ; 200
	i32 138, ; 201
	i32 86, ; 202
	i32 12, ; 203
	i32 94, ; 204
	i32 117, ; 205
	i32 68, ; 206
	i32 130, ; 207
	i32 54, ; 208
	i32 7, ; 209
	i32 104, ; 210
	i32 59, ; 211
	i32 69, ; 212
	i32 24, ; 213
	i32 126, ; 214
	i32 57, ; 215
	i32 137, ; 216
	i32 71, ; 217
	i32 3, ; 218
	i32 38, ; 219
	i32 135, ; 220
	i32 11, ; 221
	i32 87, ; 222
	i32 139, ; 223
	i32 24, ; 224
	i32 23, ; 225
	i32 126, ; 226
	i32 131, ; 227
	i32 31, ; 228
	i32 80, ; 229
	i32 98, ; 230
	i32 63, ; 231
	i32 28, ; 232
	i32 68, ; 233
	i32 37, ; 234
	i32 102, ; 235
	i32 139, ; 236
	i32 33, ; 237
	i32 109, ; 238
	i32 67, ; 239
	i32 101, ; 240
	i32 50, ; 241
	i32 55, ; 242
	i32 83, ; 243
	i32 84, ; 244
	i32 35, ; 245
	i32 109, ; 246
	i32 124, ; 247
	i32 39, ; 248
	i32 118, ; 249
	i32 108, ; 250
	i32 32, ; 251
	i32 82, ; 252
	i32 57, ; 253
	i32 74, ; 254
	i32 132, ; 255
	i32 70, ; 256
	i32 52, ; 257
	i32 27, ; 258
	i32 9, ; 259
	i32 99, ; 260
	i32 45, ; 261
	i32 115, ; 262
	i32 113, ; 263
	i32 130, ; 264
	i32 47, ; 265
	i32 93, ; 266
	i32 112, ; 267
	i32 22, ; 268
	i32 17, ; 269
	i32 38, ; 270
	i32 115, ; 271
	i32 29, ; 272
	i32 122, ; 273
	i32 65, ; 274
	i32 50, ; 275
	i32 80, ; 276
	i32 44, ; 277
	i32 120, ; 278
	i32 65 ; 279
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}
