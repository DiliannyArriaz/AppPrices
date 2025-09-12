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

@assembly_image_cache = dso_local local_unnamed_addr global [333 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [660 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 67
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 66
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 107
	i32 32687329, ; 3: Xamarin.AndroidX.Lifecycle.Runtime => 0x1f2c4e1 => 232
	i32 34715100, ; 4: Xamarin.Google.Guava.ListenableFuture.dll => 0x211b5dc => 281
	i32 34839235, ; 5: System.IO.FileSystem.DriveInfo => 0x2139ac3 => 47
	i32 39109920, ; 6: Newtonsoft.Json.dll => 0x254c520 => 189
	i32 39485524, ; 7: System.Net.WebSockets.dll => 0x25a8054 => 79
	i32 42639949, ; 8: System.Threading.Thread => 0x28aa24d => 144
	i32 52239042, ; 9: HtmlAgilityPack => 0x31d1ac2 => 173
	i32 66541672, ; 10: System.Diagnostics.StackTrace => 0x3f75868 => 29
	i32 67008169, ; 11: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 328
	i32 68219467, ; 12: System.Security.Cryptography.Primitives => 0x410f24b => 123
	i32 72070932, ; 13: Microsoft.Maui.Graphics.dll => 0x44bb714 => 188
	i32 82292897, ; 14: System.Runtime.CompilerServices.VisualC.dll => 0x4e7b0a1 => 101
	i32 101534019, ; 15: Xamarin.AndroidX.SlidingPaneLayout => 0x60d4943 => 250
	i32 103834273, ; 16: Xamarin.Firebase.Annotations.dll => 0x63062a1 => 262
	i32 117431740, ; 17: System.Runtime.InteropServices => 0x6ffddbc => 106
	i32 120558881, ; 18: Xamarin.AndroidX.SlidingPaneLayout.dll => 0x72f9521 => 250
	i32 122350210, ; 19: System.Threading.Channels.dll => 0x74aea82 => 138
	i32 134690465, ; 20: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x80736a1 => 291
	i32 142721839, ; 21: System.Net.WebHeaderCollection => 0x881c32f => 76
	i32 149972175, ; 22: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 123
	i32 159306688, ; 23: System.ComponentModel.Annotations => 0x97ed3c0 => 13
	i32 165246403, ; 24: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 206
	i32 176265551, ; 25: System.ServiceProcess => 0xa81994f => 131
	i32 182336117, ; 26: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 252
	i32 184328833, ; 27: System.ValueTuple.dll => 0xafca281 => 150
	i32 195452805, ; 28: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 325
	i32 199333315, ; 29: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 326
	i32 205061960, ; 30: System.ComponentModel => 0xc38ff48 => 18
	i32 209399409, ; 31: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 204
	i32 220171995, ; 32: System.Diagnostics.Debug => 0xd1f8edb => 26
	i32 230216969, ; 33: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0xdb8d509 => 226
	i32 230752869, ; 34: Microsoft.CSharp.dll => 0xdc10265 => 1
	i32 231409092, ; 35: System.Linq.Parallel => 0xdcb05c4 => 58
	i32 231814094, ; 36: System.Globalization => 0xdd133ce => 41
	i32 246610117, ; 37: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 90
	i32 261689757, ; 38: Xamarin.AndroidX.ConstraintLayout.dll => 0xf99119d => 209
	i32 276479776, ; 39: System.Threading.Timer.dll => 0x107abf20 => 146
	i32 278686392, ; 40: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x109c6ab8 => 228
	i32 280482487, ; 41: Xamarin.AndroidX.Interpolator => 0x10b7d2b7 => 225
	i32 280992041, ; 42: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 297
	i32 291076382, ; 43: System.IO.Pipes.AccessControl.dll => 0x1159791e => 53
	i32 298918909, ; 44: System.Net.Ping.dll => 0x11d123fd => 68
	i32 317674968, ; 45: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 325
	i32 318968648, ; 46: Xamarin.AndroidX.Activity.dll => 0x13031348 => 195
	i32 321597661, ; 47: System.Numerics => 0x132b30dd => 82
	i32 336156722, ; 48: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 310
	i32 342366114, ; 49: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 227
	i32 356389973, ; 50: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 309
	i32 360082299, ; 51: System.ServiceModel.Web => 0x15766b7b => 130
	i32 367780167, ; 52: System.IO.Pipes => 0x15ebe147 => 54
	i32 374914964, ; 53: System.Transactions.Local => 0x1658bf94 => 148
	i32 375677976, ; 54: System.Net.ServicePoint.dll => 0x16646418 => 73
	i32 379916513, ; 55: System.Threading.Thread.dll => 0x16a510e1 => 144
	i32 385762202, ; 56: System.Memory.dll => 0x16fe439a => 61
	i32 392610295, ; 57: System.Threading.ThreadPool.dll => 0x1766c1f7 => 145
	i32 395744057, ; 58: _Microsoft.Android.Resource.Designer => 0x17969339 => 329
	i32 403441872, ; 59: WindowsBase => 0x180c08d0 => 164
	i32 435591531, ; 60: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 321
	i32 441335492, ; 61: Xamarin.AndroidX.ConstraintLayout.Core => 0x1a4e3ec4 => 210
	i32 442565967, ; 62: System.Collections => 0x1a61054f => 12
	i32 450948140, ; 63: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 223
	i32 451504562, ; 64: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 124
	i32 456227837, ; 65: System.Web.HttpUtility.dll => 0x1b317bfd => 151
	i32 459347974, ; 66: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 112
	i32 465846621, ; 67: mscorlib => 0x1bc4415d => 165
	i32 469710990, ; 68: System.dll => 0x1bff388e => 163
	i32 476646585, ; 69: Xamarin.AndroidX.Interpolator.dll => 0x1c690cb9 => 225
	i32 485140951, ; 70: Xamarin.Google.Android.DataTransport.TransportRuntime => 0x1ceaa9d7 => 276
	i32 486930444, ; 71: Xamarin.AndroidX.LocalBroadcastManager.dll => 0x1d05f80c => 238
	i32 495452658, ; 72: Xamarin.Google.Android.DataTransport.TransportRuntime.dll => 0x1d8801f2 => 276
	i32 498788369, ; 73: System.ObjectModel => 0x1dbae811 => 83
	i32 500358224, ; 74: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 308
	i32 503918385, ; 75: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 302
	i32 507148113, ; 76: Xamarin.Google.Android.DataTransport.TransportApi.dll => 0x1e3a7751 => 274
	i32 513247710, ; 77: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 182
	i32 526420162, ; 78: System.Transactions.dll => 0x1f6088c2 => 149
	i32 527452488, ; 79: Xamarin.Kotlin.StdLib.Jdk7 => 0x1f704948 => 291
	i32 530272170, ; 80: System.Linq.Queryable => 0x1f9b4faa => 59
	i32 539058512, ; 81: Microsoft.Extensions.Logging => 0x20216150 => 178
	i32 540030774, ; 82: System.IO.FileSystem.dll => 0x20303736 => 50
	i32 542030372, ; 83: Xamarin.GooglePlayServices.Stats => 0x204eba24 => 285
	i32 545304856, ; 84: System.Runtime.Extensions => 0x2080b118 => 102
	i32 546455878, ; 85: System.Runtime.Serialization.Xml => 0x20924146 => 113
	i32 549171840, ; 86: System.Globalization.Calendars => 0x20bbb280 => 39
	i32 557405415, ; 87: Jsr305Binding => 0x213954e7 => 278
	i32 569601784, ; 88: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x21f36ef8 => 261
	i32 577335427, ; 89: System.Security.Cryptography.Cng => 0x22697083 => 119
	i32 592146354, ; 90: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 316
	i32 601371474, ; 91: System.IO.IsolatedStorage.dll => 0x23d83352 => 51
	i32 605376203, ; 92: System.IO.Compression.FileSystem => 0x24154ecb => 43
	i32 613668793, ; 93: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 118
	i32 627609679, ; 94: Xamarin.AndroidX.CustomView => 0x2568904f => 215
	i32 627931235, ; 95: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 314
	i32 639843206, ; 96: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x26233b86 => 221
	i32 643868501, ; 97: System.Net => 0x2660a755 => 80
	i32 662205335, ; 98: System.Text.Encodings.Web.dll => 0x27787397 => 135
	i32 663517072, ; 99: Xamarin.AndroidX.VersionedParcelable => 0x278c7790 => 257
	i32 666292255, ; 100: Xamarin.AndroidX.Arch.Core.Common.dll => 0x27b6d01f => 202
	i32 672442732, ; 101: System.Collections.Concurrent => 0x2814a96c => 8
	i32 683518922, ; 102: System.Net.Security => 0x28bdabca => 72
	i32 688181140, ; 103: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 296
	i32 690569205, ; 104: System.Xml.Linq.dll => 0x29293ff5 => 154
	i32 691348768, ; 105: Xamarin.KotlinX.Coroutines.Android.dll => 0x29352520 => 293
	i32 693804605, ; 106: System.Windows => 0x295a9e3d => 153
	i32 699345723, ; 107: System.Reflection.Emit => 0x29af2b3b => 91
	i32 700284507, ; 108: Xamarin.Jetbrains.Annotations => 0x29bd7e5b => 288
	i32 700358131, ; 109: System.IO.Compression.ZipFile => 0x29be9df3 => 44
	i32 706645707, ; 110: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 311
	i32 709557578, ; 111: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 299
	i32 720511267, ; 112: Xamarin.Kotlin.StdLib.Jdk8 => 0x2af22123 => 292
	i32 722857257, ; 113: System.Runtime.Loader.dll => 0x2b15ed29 => 108
	i32 735137430, ; 114: System.Security.SecureString.dll => 0x2bd14e96 => 128
	i32 752232764, ; 115: System.Diagnostics.Contracts.dll => 0x2cd6293c => 25
	i32 755313932, ; 116: Xamarin.Android.Glide.Annotations.dll => 0x2d052d0c => 192
	i32 759454413, ; 117: System.Net.Requests => 0x2d445acd => 71
	i32 762598435, ; 118: System.IO.Pipes.dll => 0x2d745423 => 54
	i32 775507847, ; 119: System.IO.Compression => 0x2e394f87 => 45
	i32 777317022, ; 120: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 320
	i32 789151979, ; 121: Microsoft.Extensions.Options => 0x2f0980eb => 181
	i32 790371945, ; 122: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0x2f1c1e69 => 216
	i32 804715423, ; 123: System.Data.Common => 0x2ff6fb9f => 22
	i32 807930345, ; 124: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x302809e9 => 230
	i32 823281589, ; 125: System.Private.Uri.dll => 0x311247b5 => 85
	i32 830298997, ; 126: System.IO.Compression.Brotli => 0x317d5b75 => 42
	i32 832635846, ; 127: System.Xml.XPath.dll => 0x31a103c6 => 159
	i32 834051424, ; 128: System.Net.Quic => 0x31b69d60 => 70
	i32 843511501, ; 129: Xamarin.AndroidX.Print => 0x3246f6cd => 243
	i32 846667644, ; 130: Xamarin.Firebase.Installations.dll => 0x32771f7c => 270
	i32 873119928, ; 131: Microsoft.VisualBasic => 0x340ac0b8 => 3
	i32 877678880, ; 132: System.Globalization.dll => 0x34505120 => 41
	i32 878954865, ; 133: System.Net.Http.Json => 0x3463c971 => 62
	i32 882434999, ; 134: Xamarin.Firebase.Installations.InterOp.dll => 0x3498e3b7 => 271
	i32 904024072, ; 135: System.ComponentModel.Primitives.dll => 0x35e25008 => 16
	i32 911108515, ; 136: System.IO.MemoryMappedFiles.dll => 0x364e69a3 => 52
	i32 926902833, ; 137: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 323
	i32 928116545, ; 138: Xamarin.Google.Guava.ListenableFuture => 0x3751ef41 => 281
	i32 952186615, ; 139: System.Runtime.InteropServices.JavaScript.dll => 0x38c136f7 => 104
	i32 955402788, ; 140: Newtonsoft.Json => 0x38f24a24 => 189
	i32 956575887, ; 141: Xamarin.Kotlin.StdLib.Jdk8.dll => 0x3904308f => 292
	i32 966729478, ; 142: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 279
	i32 967690846, ; 143: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 227
	i32 975236339, ; 144: System.Diagnostics.Tracing => 0x3a20ecf3 => 33
	i32 975874589, ; 145: System.Xml.XDocument => 0x3a2aaa1d => 157
	i32 986514023, ; 146: System.Private.DataContractSerialization.dll => 0x3acd0267 => 84
	i32 987214855, ; 147: System.Diagnostics.Tools => 0x3ad7b407 => 31
	i32 992768348, ; 148: System.Collections.dll => 0x3b2c715c => 12
	i32 994442037, ; 149: System.IO.FileSystem => 0x3b45fb35 => 50
	i32 996733531, ; 150: Xamarin.Google.Android.DataTransport.TransportBackendCct => 0x3b68f25b => 275
	i32 1001831731, ; 151: System.IO.UnmanagedMemoryStream.dll => 0x3bb6bd33 => 55
	i32 1012816738, ; 152: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 247
	i32 1019214401, ; 153: System.Drawing => 0x3cbffa41 => 35
	i32 1028951442, ; 154: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 177
	i32 1029334545, ; 155: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 298
	i32 1031528504, ; 156: Xamarin.Google.ErrorProne.Annotations.dll => 0x3d7be038 => 280
	i32 1035644815, ; 157: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 200
	i32 1036359102, ; 158: Xamarin.GooglePlayServices.CloudMessaging.dll => 0x3dc595be => 284
	i32 1036536393, ; 159: System.Drawing.Primitives.dll => 0x3dc84a49 => 34
	i32 1044663988, ; 160: System.Linq.Expressions.dll => 0x3e444eb4 => 57
	i32 1052210849, ; 161: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 234
	i32 1067306892, ; 162: GoogleGson => 0x3f9dcf8c => 172
	i32 1082857460, ; 163: System.ComponentModel.TypeConverter => 0x408b17f4 => 17
	i32 1084122840, ; 164: Xamarin.Kotlin.StdLib => 0x409e66d8 => 289
	i32 1098259244, ; 165: System => 0x41761b2c => 163
	i32 1118262833, ; 166: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 311
	i32 1121599056, ; 167: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0x42da3e50 => 233
	i32 1127624469, ; 168: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 180
	i32 1141947663, ; 169: Xamarin.Firebase.Measurement.Connector.dll => 0x4410bd0f => 272
	i32 1149092582, ; 170: Xamarin.AndroidX.Window => 0x447dc2e6 => 260
	i32 1168523401, ; 171: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 317
	i32 1170634674, ; 172: System.Web.dll => 0x45c677b2 => 152
	i32 1175144683, ; 173: Xamarin.AndroidX.VectorDrawable.Animated => 0x460b48eb => 256
	i32 1178241025, ; 174: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 241
	i32 1203215381, ; 175: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 315
	i32 1204270330, ; 176: Xamarin.AndroidX.Arch.Core.Common => 0x47c7b4fa => 202
	i32 1208641965, ; 177: System.Diagnostics.Process => 0x480a69ad => 28
	i32 1219128291, ; 178: System.IO.IsolatedStorage => 0x48aa6be3 => 51
	i32 1234928153, ; 179: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 313
	i32 1243150071, ; 180: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x4a18f6f7 => 261
	i32 1253011324, ; 181: Microsoft.Win32.Registry => 0x4aaf6f7c => 5
	i32 1260983243, ; 182: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 297
	i32 1264511973, ; 183: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0x4b5eebe5 => 251
	i32 1267360935, ; 184: Xamarin.AndroidX.VectorDrawable => 0x4b8a64a7 => 255
	i32 1273260888, ; 185: Xamarin.AndroidX.Collection.Ktx => 0x4be46b58 => 207
	i32 1275534314, ; 186: Xamarin.KotlinX.Coroutines.Android => 0x4c071bea => 293
	i32 1278448581, ; 187: Xamarin.AndroidX.Annotation.Jvm => 0x4c3393c5 => 199
	i32 1293217323, ; 188: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 218
	i32 1309188875, ; 189: System.Private.DataContractSerialization => 0x4e08a30b => 84
	i32 1322716291, ; 190: Xamarin.AndroidX.Window.dll => 0x4ed70c83 => 260
	i32 1324164729, ; 191: System.Linq => 0x4eed2679 => 60
	i32 1333047053, ; 192: Xamarin.Firebase.Common => 0x4f74af0d => 263
	i32 1335329327, ; 193: System.Runtime.Serialization.Json.dll => 0x4f97822f => 111
	i32 1364015309, ; 194: System.IO => 0x514d38cd => 56
	i32 1373134921, ; 195: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 327
	i32 1376866003, ; 196: Xamarin.AndroidX.SavedState => 0x52114ed3 => 247
	i32 1379779777, ; 197: System.Resources.ResourceManager => 0x523dc4c1 => 98
	i32 1379897097, ; 198: Xamarin.JavaX.Inject => 0x523f8f09 => 287
	i32 1402170036, ; 199: System.Configuration.dll => 0x53936ab4 => 19
	i32 1406073936, ; 200: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 211
	i32 1408764838, ; 201: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 110
	i32 1411638395, ; 202: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 100
	i32 1422545099, ; 203: System.Runtime.CompilerServices.VisualC => 0x54ca50cb => 101
	i32 1430672901, ; 204: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 295
	i32 1434145427, ; 205: System.Runtime.Handles => 0x557b5293 => 103
	i32 1435222561, ; 206: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 279
	i32 1439761251, ; 207: System.Net.Quic.dll => 0x55d10363 => 70
	i32 1452070440, ; 208: System.Formats.Asn1.dll => 0x568cd628 => 37
	i32 1453312822, ; 209: System.Diagnostics.Tools.dll => 0x569fcb36 => 31
	i32 1457743152, ; 210: System.Runtime.Extensions.dll => 0x56e36530 => 102
	i32 1458022317, ; 211: System.Net.Security.dll => 0x56e7a7ad => 72
	i32 1461004990, ; 212: es\Microsoft.Maui.Controls.resources => 0x57152abe => 301
	i32 1461234159, ; 213: System.Collections.Immutable.dll => 0x5718a9ef => 9
	i32 1461719063, ; 214: System.Security.Cryptography.OpenSsl => 0x57201017 => 122
	i32 1462112819, ; 215: System.IO.Compression.dll => 0x57261233 => 45
	i32 1469204771, ; 216: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 201
	i32 1470490898, ; 217: Microsoft.Extensions.Primitives => 0x57a5e912 => 182
	i32 1479771757, ; 218: System.Collections.Immutable => 0x5833866d => 9
	i32 1480492111, ; 219: System.IO.Compression.Brotli.dll => 0x583e844f => 42
	i32 1487239319, ; 220: Microsoft.Win32.Primitives => 0x58a57897 => 4
	i32 1490025113, ; 221: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x58cffa99 => 248
	i32 1493001747, ; 222: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 305
	i32 1514721132, ; 223: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 300
	i32 1531040989, ; 224: Xamarin.Firebase.Iid.Interop.dll => 0x5b41d4dd => 269
	i32 1536373174, ; 225: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 30
	i32 1543031311, ; 226: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 137
	i32 1543355203, ; 227: System.Reflection.Emit.dll => 0x5bfdbb43 => 91
	i32 1550322496, ; 228: System.Reflection.Extensions.dll => 0x5c680b40 => 92
	i32 1551623176, ; 229: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 320
	i32 1565862583, ; 230: System.IO.FileSystem.Primitives => 0x5d552ab7 => 48
	i32 1566207040, ; 231: System.Threading.Tasks.Dataflow.dll => 0x5d5a6c40 => 140
	i32 1573704789, ; 232: System.Runtime.Serialization.Json => 0x5dccd455 => 111
	i32 1580037396, ; 233: System.Threading.Overlapped => 0x5e2d7514 => 139
	i32 1582372066, ; 234: Xamarin.AndroidX.DocumentFile.dll => 0x5e5114e2 => 217
	i32 1592978981, ; 235: System.Runtime.Serialization.dll => 0x5ef2ee25 => 114
	i32 1597949149, ; 236: Xamarin.Google.ErrorProne.Annotations => 0x5f3ec4dd => 280
	i32 1601112923, ; 237: System.Xml.Serialization => 0x5f6f0b5b => 156
	i32 1604827217, ; 238: System.Net.WebClient => 0x5fa7b851 => 75
	i32 1618516317, ; 239: System.Net.WebSockets.Client.dll => 0x6078995d => 78
	i32 1622152042, ; 240: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 237
	i32 1622358360, ; 241: System.Dynamic.Runtime => 0x60b33958 => 36
	i32 1624863272, ; 242: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 259
	i32 1635184631, ; 243: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x6176eff7 => 221
	i32 1636350590, ; 244: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 214
	i32 1639515021, ; 245: System.Net.Http.dll => 0x61b9038d => 63
	i32 1639986890, ; 246: System.Text.RegularExpressions => 0x61c036ca => 137
	i32 1641389582, ; 247: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 15
	i32 1657153582, ; 248: System.Runtime => 0x62c6282e => 115
	i32 1658241508, ; 249: Xamarin.AndroidX.Tracing.Tracing.dll => 0x62d6c1e4 => 253
	i32 1658251792, ; 250: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 277
	i32 1670060433, ; 251: Xamarin.AndroidX.ConstraintLayout => 0x638b1991 => 209
	i32 1675553242, ; 252: System.IO.FileSystem.DriveInfo.dll => 0x63dee9da => 47
	i32 1677501392, ; 253: System.Net.Primitives.dll => 0x63fca3d0 => 69
	i32 1678508291, ; 254: System.Net.WebSockets => 0x640c0103 => 79
	i32 1679769178, ; 255: System.Security.Cryptography => 0x641f3e5a => 125
	i32 1691477237, ; 256: System.Reflection.Metadata => 0x64d1e4f5 => 93
	i32 1696967625, ; 257: System.Security.Cryptography.Csp => 0x6525abc9 => 120
	i32 1698840827, ; 258: Xamarin.Kotlin.StdLib.Common => 0x654240fb => 290
	i32 1701541528, ; 259: System.Diagnostics.Debug.dll => 0x656b7698 => 26
	i32 1720223769, ; 260: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x66888819 => 230
	i32 1726116996, ; 261: System.Reflection.dll => 0x66e27484 => 96
	i32 1728033016, ; 262: System.Diagnostics.FileVersionInfo.dll => 0x66ffb0f8 => 27
	i32 1729485958, ; 263: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 205
	i32 1736233607, ; 264: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 318
	i32 1743415430, ; 265: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 296
	i32 1744735666, ; 266: System.Transactions.Local.dll => 0x67fe8db2 => 148
	i32 1746316138, ; 267: Mono.Android.Export => 0x6816ab6a => 168
	i32 1750313021, ; 268: Microsoft.Win32.Primitives.dll => 0x6853a83d => 4
	i32 1758240030, ; 269: System.Resources.Reader.dll => 0x68cc9d1e => 97
	i32 1763938596, ; 270: System.Diagnostics.TraceSource.dll => 0x69239124 => 32
	i32 1765942094, ; 271: System.Reflection.Extensions => 0x6942234e => 92
	i32 1766324549, ; 272: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 252
	i32 1770582343, ; 273: Microsoft.Extensions.Logging.dll => 0x6988f147 => 178
	i32 1776026572, ; 274: System.Core.dll => 0x69dc03cc => 21
	i32 1777075843, ; 275: System.Globalization.Extensions.dll => 0x69ec0683 => 40
	i32 1780572499, ; 276: Mono.Android.Runtime.dll => 0x6a216153 => 169
	i32 1782862114, ; 277: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 312
	i32 1788241197, ; 278: Xamarin.AndroidX.Fragment => 0x6a96652d => 223
	i32 1793755602, ; 279: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 304
	i32 1808609942, ; 280: Xamarin.AndroidX.Loader => 0x6bcd3296 => 237
	i32 1813058853, ; 281: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 289
	i32 1813201214, ; 282: Xamarin.Google.Android.Material => 0x6c13413e => 277
	i32 1818569960, ; 283: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 242
	i32 1818787751, ; 284: Microsoft.VisualBasic.Core => 0x6c687fa7 => 2
	i32 1824175904, ; 285: System.Text.Encoding.Extensions => 0x6cbab720 => 133
	i32 1824722060, ; 286: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 110
	i32 1828688058, ; 287: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 179
	i32 1842015223, ; 288: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 324
	i32 1847515442, ; 289: Xamarin.Android.Glide.Annotations => 0x6e1ed932 => 192
	i32 1853025655, ; 290: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 321
	i32 1858542181, ; 291: System.Linq.Expressions => 0x6ec71a65 => 57
	i32 1870277092, ; 292: System.Reflection.Primitives => 0x6f7a29e4 => 94
	i32 1875935024, ; 293: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 303
	i32 1876173635, ; 294: Xamarin.Firebase.Encoders.Proto => 0x6fd42343 => 268
	i32 1879696579, ; 295: System.Formats.Tar.dll => 0x7009e4c3 => 38
	i32 1885316902, ; 296: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0x705fa726 => 203
	i32 1888955245, ; 297: System.Diagnostics.Contracts => 0x70972b6d => 25
	i32 1889954781, ; 298: System.Reflection.Metadata.dll => 0x70a66bdd => 93
	i32 1898237753, ; 299: System.Reflection.DispatchProxy => 0x7124cf39 => 88
	i32 1900610850, ; 300: System.Resources.ResourceManager.dll => 0x71490522 => 98
	i32 1908813208, ; 301: Xamarin.GooglePlayServices.Basement => 0x71c62d98 => 283
	i32 1910275211, ; 302: System.Collections.NonGeneric.dll => 0x71dc7c8b => 10
	i32 1933215285, ; 303: Xamarin.Firebase.Messaging.dll => 0x733a8635 => 273
	i32 1939592360, ; 304: System.Private.Xml.Linq => 0x739bd4a8 => 86
	i32 1956758971, ; 305: System.Resources.Writer => 0x74a1c5bb => 99
	i32 1961813231, ; 306: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 249
	i32 1968388702, ; 307: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 174
	i32 1983156543, ; 308: Xamarin.Kotlin.StdLib.Common.dll => 0x7634913f => 290
	i32 1985761444, ; 309: Xamarin.Android.Glide.GifDecoder => 0x765c50a4 => 194
	i32 2003115576, ; 310: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 300
	i32 2011961780, ; 311: System.Buffers.dll => 0x77ec19b4 => 7
	i32 2019465201, ; 312: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 234
	i32 2025202353, ; 313: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 295
	i32 2031763787, ; 314: Xamarin.Android.Glide => 0x791a414b => 191
	i32 2045470958, ; 315: System.Private.Xml => 0x79eb68ee => 87
	i32 2055257422, ; 316: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 229
	i32 2060060697, ; 317: System.Windows.dll => 0x7aca0819 => 153
	i32 2066184531, ; 318: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 299
	i32 2070888862, ; 319: System.Diagnostics.TraceSource => 0x7b6f419e => 32
	i32 2079903147, ; 320: System.Runtime.dll => 0x7bf8cdab => 115
	i32 2090596640, ; 321: System.Numerics.Vectors => 0x7c9bf920 => 81
	i32 2124230737, ; 322: Xamarin.Google.Android.DataTransport.TransportBackendCct.dll => 0x7e9d3051 => 275
	i32 2127167465, ; 323: System.Console => 0x7ec9ffe9 => 20
	i32 2129483829, ; 324: Xamarin.GooglePlayServices.Base.dll => 0x7eed5835 => 282
	i32 2142473426, ; 325: System.Collections.Specialized => 0x7fb38cd2 => 11
	i32 2143790110, ; 326: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 161
	i32 2146852085, ; 327: Microsoft.VisualBasic.dll => 0x7ff65cf5 => 3
	i32 2159891885, ; 328: Microsoft.Maui => 0x80bd55ad => 186
	i32 2169148018, ; 329: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 307
	i32 2174878672, ; 330: Xamarin.Firebase.Annotations => 0x81a203d0 => 262
	i32 2181898931, ; 331: Microsoft.Extensions.Options.dll => 0x820d22b3 => 181
	i32 2192057212, ; 332: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 179
	i32 2193016926, ; 333: System.ObjectModel.dll => 0x82b6c85e => 83
	i32 2201107256, ; 334: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 294
	i32 2201231467, ; 335: System.Net.Http => 0x8334206b => 63
	i32 2207618523, ; 336: it\Microsoft.Maui.Controls.resources => 0x839595db => 309
	i32 2217644978, ; 337: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x842e93b2 => 256
	i32 2222056684, ; 338: System.Threading.Tasks.Parallel => 0x8471e4ec => 142
	i32 2244775296, ; 339: Xamarin.AndroidX.LocalBroadcastManager => 0x85cc8d80 => 238
	i32 2252106437, ; 340: System.Xml.Serialization.dll => 0x863c6ac5 => 156
	i32 2256313426, ; 341: System.Globalization.Extensions => 0x867c9c52 => 40
	i32 2265110946, ; 342: System.Security.AccessControl.dll => 0x8702d9a2 => 116
	i32 2266799131, ; 343: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 175
	i32 2267999099, ; 344: Xamarin.Android.Glide.DiskLruCache.dll => 0x872eeb7b => 193
	i32 2270573516, ; 345: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 303
	i32 2279755925, ; 346: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 245
	i32 2293034957, ; 347: System.ServiceModel.Web.dll => 0x88acefcd => 130
	i32 2295906218, ; 348: System.Net.Sockets => 0x88d8bfaa => 74
	i32 2298471582, ; 349: System.Net.Mail => 0x88ffe49e => 65
	i32 2303942373, ; 350: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 313
	i32 2305521784, ; 351: System.Private.CoreLib.dll => 0x896b7878 => 171
	i32 2315684594, ; 352: Xamarin.AndroidX.Annotation.dll => 0x8a068af2 => 197
	i32 2320631194, ; 353: System.Threading.Tasks.Parallel.dll => 0x8a52059a => 142
	i32 2340441535, ; 354: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 105
	i32 2344264397, ; 355: System.ValueTuple => 0x8bbaa2cd => 150
	i32 2353062107, ; 356: System.Net.Primitives => 0x8c40e0db => 69
	i32 2368005991, ; 357: System.Xml.ReaderWriter.dll => 0x8d24e767 => 155
	i32 2371007202, ; 358: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 174
	i32 2378619854, ; 359: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 120
	i32 2383496789, ; 360: System.Security.Principal.Windows.dll => 0x8e114655 => 126
	i32 2395872292, ; 361: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 308
	i32 2401565422, ; 362: System.Web.HttpUtility => 0x8f24faee => 151
	i32 2403452196, ; 363: Xamarin.AndroidX.Emoji2.dll => 0x8f41c524 => 220
	i32 2421380589, ; 364: System.Threading.Tasks.Dataflow => 0x905355ed => 140
	i32 2423080555, ; 365: Xamarin.AndroidX.Collection.Ktx.dll => 0x906d466b => 207
	i32 2427813419, ; 366: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 305
	i32 2435356389, ; 367: System.Console.dll => 0x912896e5 => 20
	i32 2435904999, ; 368: System.ComponentModel.DataAnnotations.dll => 0x9130f5e7 => 14
	i32 2454642406, ; 369: System.Text.Encoding.dll => 0x924edee6 => 134
	i32 2458678730, ; 370: System.Net.Sockets.dll => 0x928c75ca => 74
	i32 2459001652, ; 371: System.Linq.Parallel.dll => 0x92916334 => 58
	i32 2465532216, ; 372: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x92f50938 => 210
	i32 2471841756, ; 373: netstandard.dll => 0x93554fdc => 166
	i32 2475788418, ; 374: Java.Interop.dll => 0x93918882 => 167
	i32 2480646305, ; 375: Microsoft.Maui.Controls => 0x93dba8a1 => 184
	i32 2483661569, ; 376: Xamarin.Firebase.Measurement.Connector => 0x9409ab01 => 272
	i32 2483742551, ; 377: Xamarin.Firebase.Messaging => 0x940ae757 => 273
	i32 2483903535, ; 378: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 15
	i32 2484371297, ; 379: System.Net.ServicePoint => 0x94147f61 => 73
	i32 2486410006, ; 380: Xamarin.GooglePlayServices.CloudMessaging => 0x94339b16 => 284
	i32 2490993605, ; 381: System.AppContext.dll => 0x94798bc5 => 6
	i32 2501346920, ; 382: System.Data.DataSetExtensions => 0x95178668 => 23
	i32 2505896520, ; 383: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x955cf248 => 232
	i32 2522472828, ; 384: Xamarin.Android.Glide.dll => 0x9659e17c => 191
	i32 2538310050, ; 385: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 90
	i32 2550873716, ; 386: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 306
	i32 2562349572, ; 387: Microsoft.CSharp => 0x98ba5a04 => 1
	i32 2570120770, ; 388: System.Text.Encodings.Web => 0x9930ee42 => 135
	i32 2581783588, ; 389: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x99e2e424 => 233
	i32 2581819634, ; 390: Xamarin.AndroidX.VectorDrawable.dll => 0x99e370f2 => 255
	i32 2585220780, ; 391: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 133
	i32 2585805581, ; 392: System.Net.Ping => 0x9a20430d => 68
	i32 2589602615, ; 393: System.Threading.ThreadPool => 0x9a5a3337 => 145
	i32 2593496499, ; 394: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 315
	i32 2605712449, ; 395: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 294
	i32 2615233544, ; 396: Xamarin.AndroidX.Fragment.Ktx => 0x9be14c08 => 224
	i32 2616218305, ; 397: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 180
	i32 2617129537, ; 398: System.Private.Xml.dll => 0x9bfe3a41 => 87
	i32 2618712057, ; 399: System.Reflection.TypeExtensions.dll => 0x9c165ff9 => 95
	i32 2620111890, ; 400: Xamarin.Firebase.Encoders.dll => 0x9c2bbc12 => 266
	i32 2620871830, ; 401: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 214
	i32 2623491480, ; 402: Xamarin.Firebase.Installations.InterOp => 0x9c5f4d98 => 271
	i32 2624644809, ; 403: Xamarin.AndroidX.DynamicAnimation => 0x9c70e6c9 => 219
	i32 2626831493, ; 404: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 310
	i32 2627185994, ; 405: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 30
	i32 2629843544, ; 406: System.IO.Compression.ZipFile.dll => 0x9cc03a58 => 44
	i32 2633051222, ; 407: Xamarin.AndroidX.Lifecycle.LiveData => 0x9cf12c56 => 228
	i32 2639764100, ; 408: Xamarin.Firebase.Encoders => 0x9d579a84 => 266
	i32 2663391936, ; 409: Xamarin.Android.Glide.DiskLruCache => 0x9ec022c0 => 193
	i32 2663698177, ; 410: System.Runtime.Loader => 0x9ec4cf01 => 108
	i32 2664396074, ; 411: System.Xml.XDocument.dll => 0x9ecf752a => 157
	i32 2665622720, ; 412: System.Drawing.Primitives => 0x9ee22cc0 => 34
	i32 2676780864, ; 413: System.Data.Common.dll => 0x9f8c6f40 => 22
	i32 2686887180, ; 414: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 113
	i32 2693849962, ; 415: System.IO.dll => 0xa090e36a => 56
	i32 2701096212, ; 416: Xamarin.AndroidX.Tracing.Tracing => 0xa0ff7514 => 253
	i32 2715334215, ; 417: System.Threading.Tasks.dll => 0xa1d8b647 => 143
	i32 2717744543, ; 418: System.Security.Claims => 0xa1fd7d9f => 117
	i32 2719963679, ; 419: System.Security.Cryptography.Cng.dll => 0xa21f5a1f => 119
	i32 2724373263, ; 420: System.Runtime.Numerics.dll => 0xa262a30f => 109
	i32 2732626843, ; 421: Xamarin.AndroidX.Activity => 0xa2e0939b => 195
	i32 2735172069, ; 422: System.Threading.Channels => 0xa30769e5 => 138
	i32 2737747696, ; 423: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 201
	i32 2740948882, ; 424: System.IO.Pipes.AccessControl => 0xa35f8f92 => 53
	i32 2748088231, ; 425: System.Runtime.InteropServices.JavaScript => 0xa3cc7fa7 => 104
	i32 2752995522, ; 426: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 316
	i32 2758225723, ; 427: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 185
	i32 2764765095, ; 428: Microsoft.Maui.dll => 0xa4caf7a7 => 186
	i32 2765824710, ; 429: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 132
	i32 2770495804, ; 430: Xamarin.Jetbrains.Annotations.dll => 0xa522693c => 288
	i32 2778768386, ; 431: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 258
	i32 2779977773, ; 432: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0xa5b3182d => 246
	i32 2785988530, ; 433: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 322
	i32 2788224221, ; 434: Xamarin.AndroidX.Fragment.Ktx.dll => 0xa630ecdd => 224
	i32 2801831435, ; 435: Microsoft.Maui.Graphics => 0xa7008e0b => 188
	i32 2803228030, ; 436: System.Xml.XPath.XDocument.dll => 0xa715dd7e => 158
	i32 2804607052, ; 437: Xamarin.Firebase.Components.dll => 0xa72ae84c => 264
	i32 2806116107, ; 438: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 301
	i32 2810250172, ; 439: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 211
	i32 2819470561, ; 440: System.Xml.dll => 0xa80db4e1 => 162
	i32 2821205001, ; 441: System.ServiceProcess.dll => 0xa8282c09 => 131
	i32 2821294376, ; 442: Xamarin.AndroidX.ResourceInspection.Annotation => 0xa8298928 => 246
	i32 2824502124, ; 443: System.Xml.XmlDocument => 0xa85a7b6c => 160
	i32 2831556043, ; 444: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 314
	i32 2838993487, ; 445: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xa9379a4f => 235
	i32 2847418871, ; 446: Xamarin.GooglePlayServices.Base => 0xa9b829f7 => 282
	i32 2849599387, ; 447: System.Threading.Overlapped.dll => 0xa9d96f9b => 139
	i32 2853208004, ; 448: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 258
	i32 2855708567, ; 449: Xamarin.AndroidX.Transition => 0xaa36a797 => 254
	i32 2861098320, ; 450: Mono.Android.Export.dll => 0xaa88e550 => 168
	i32 2861189240, ; 451: Microsoft.Maui.Essentials => 0xaa8a4878 => 187
	i32 2870099610, ; 452: Xamarin.AndroidX.Activity.Ktx.dll => 0xab123e9a => 196
	i32 2875164099, ; 453: Jsr305Binding.dll => 0xab5f85c3 => 278
	i32 2875220617, ; 454: System.Globalization.Calendars.dll => 0xab606289 => 39
	i32 2883826422, ; 455: Xamarin.Firebase.Installations => 0xabe3b2f6 => 270
	i32 2884993177, ; 456: Xamarin.AndroidX.ExifInterface => 0xabf58099 => 222
	i32 2887636118, ; 457: System.Net.dll => 0xac1dd496 => 80
	i32 2899753641, ; 458: System.IO.UnmanagedMemoryStream => 0xacd6baa9 => 55
	i32 2900621748, ; 459: System.Dynamic.Runtime.dll => 0xace3f9b4 => 36
	i32 2901442782, ; 460: System.Reflection => 0xacf080de => 96
	i32 2905242038, ; 461: mscorlib.dll => 0xad2a79b6 => 165
	i32 2909740682, ; 462: System.Private.CoreLib => 0xad6f1e8a => 171
	i32 2914202368, ; 463: Xamarin.Firebase.Iid.Interop => 0xadb33300 => 269
	i32 2916838712, ; 464: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 259
	i32 2919462931, ; 465: System.Numerics.Vectors.dll => 0xae037813 => 81
	i32 2921128767, ; 466: Xamarin.AndroidX.Annotation.Experimental.dll => 0xae1ce33f => 198
	i32 2936416060, ; 467: System.Resources.Reader => 0xaf06273c => 97
	i32 2940926066, ; 468: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 29
	i32 2942453041, ; 469: System.Xml.XPath.XDocument => 0xaf624531 => 158
	i32 2959614098, ; 470: System.ComponentModel.dll => 0xb0682092 => 18
	i32 2968338931, ; 471: System.Security.Principal.Windows => 0xb0ed41f3 => 126
	i32 2972252294, ; 472: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 118
	i32 2978675010, ; 473: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 218
	i32 2987532451, ; 474: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 249
	i32 2996846495, ; 475: Xamarin.AndroidX.Lifecycle.Process.dll => 0xb2a03f9f => 231
	i32 3016983068, ; 476: Xamarin.AndroidX.Startup.StartupRuntime => 0xb3d3821c => 251
	i32 3023353419, ; 477: WindowsBase.dll => 0xb434b64b => 164
	i32 3024354802, ; 478: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xb443fdf2 => 226
	i32 3038032645, ; 479: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 329
	i32 3056245963, ; 480: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0xb62a9ccb => 248
	i32 3057625584, ; 481: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 239
	i32 3058099980, ; 482: Xamarin.GooglePlayServices.Tasks => 0xb646e70c => 286
	i32 3059408633, ; 483: Mono.Android.Runtime => 0xb65adef9 => 169
	i32 3059793426, ; 484: System.ComponentModel.Primitives => 0xb660be12 => 16
	i32 3071899978, ; 485: Xamarin.Firebase.Common.dll => 0xb719794a => 263
	i32 3075834255, ; 486: System.Threading.Tasks => 0xb755818f => 143
	i32 3077302341, ; 487: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 307
	i32 3090735792, ; 488: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 124
	i32 3099732863, ; 489: System.Security.Claims.dll => 0xb8c22b7f => 117
	i32 3103600923, ; 490: System.Formats.Asn1 => 0xb8fd311b => 37
	i32 3106737866, ; 491: Xamarin.Firebase.Datatransport.dll => 0xb92d0eca => 265
	i32 3111772706, ; 492: System.Runtime.Serialization => 0xb979e222 => 114
	i32 3121463068, ; 493: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 46
	i32 3124832203, ; 494: System.Threading.Tasks.Extensions => 0xba4127cb => 141
	i32 3132293585, ; 495: System.Security.AccessControl => 0xbab301d1 => 116
	i32 3147165239, ; 496: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 33
	i32 3148237826, ; 497: GoogleGson.dll => 0xbba64c02 => 172
	i32 3155362983, ; 498: Xamarin.Google.Android.DataTransport.TransportApi => 0xbc1304a7 => 274
	i32 3159123045, ; 499: System.Reflection.Primitives.dll => 0xbc4c6465 => 94
	i32 3160747431, ; 500: System.IO.MemoryMappedFiles => 0xbc652da7 => 52
	i32 3178803400, ; 501: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 240
	i32 3192346100, ; 502: System.Security.SecureString => 0xbe4755f4 => 128
	i32 3193515020, ; 503: System.Web => 0xbe592c0c => 152
	i32 3204380047, ; 504: System.Data.dll => 0xbefef58f => 24
	i32 3209718065, ; 505: System.Xml.XmlDocument.dll => 0xbf506931 => 160
	i32 3211777861, ; 506: Xamarin.AndroidX.DocumentFile => 0xbf6fd745 => 217
	i32 3220365878, ; 507: System.Threading => 0xbff2e236 => 147
	i32 3226221578, ; 508: System.Runtime.Handles.dll => 0xc04c3c0a => 103
	i32 3230466174, ; 509: Xamarin.GooglePlayServices.Basement.dll => 0xc08d007e => 283
	i32 3251039220, ; 510: System.Reflection.DispatchProxy.dll => 0xc1c6ebf4 => 88
	i32 3258312781, ; 511: Xamarin.AndroidX.CardView => 0xc235e84d => 205
	i32 3265493905, ; 512: System.Linq.Queryable.dll => 0xc2a37b91 => 59
	i32 3265893370, ; 513: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 141
	i32 3277815716, ; 514: System.Resources.Writer.dll => 0xc35f7fa4 => 99
	i32 3279906254, ; 515: Microsoft.Win32.Registry.dll => 0xc37f65ce => 5
	i32 3280506390, ; 516: System.ComponentModel.Annotations.dll => 0xc3888e16 => 13
	i32 3290767353, ; 517: System.Security.Cryptography.Encoding => 0xc4251ff9 => 121
	i32 3299363146, ; 518: System.Text.Encoding => 0xc4a8494a => 134
	i32 3303498502, ; 519: System.Diagnostics.FileVersionInfo => 0xc4e76306 => 27
	i32 3305363605, ; 520: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 302
	i32 3316684772, ; 521: System.Net.Requests.dll => 0xc5b097e4 => 71
	i32 3317135071, ; 522: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 215
	i32 3317144872, ; 523: System.Data => 0xc5b79d28 => 24
	i32 3331531814, ; 524: Xamarin.GooglePlayServices.Stats.dll => 0xc6932426 => 285
	i32 3340431453, ; 525: Xamarin.AndroidX.Arch.Core.Runtime => 0xc71af05d => 203
	i32 3345895724, ; 526: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xc76e512c => 244
	i32 3346324047, ; 527: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 241
	i32 3357674450, ; 528: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 319
	i32 3358260929, ; 529: System.Text.Json => 0xc82afec1 => 136
	i32 3362336904, ; 530: Xamarin.AndroidX.Activity.Ktx => 0xc8693088 => 196
	i32 3362522851, ; 531: Xamarin.AndroidX.Core => 0xc86c06e3 => 212
	i32 3366347497, ; 532: Java.Interop => 0xc8a662e9 => 167
	i32 3371992681, ; 533: Xamarin.Firebase.Encoders.Proto.dll => 0xc8fc8669 => 268
	i32 3374999561, ; 534: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 245
	i32 3381016424, ; 535: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 298
	i32 3383578424, ; 536: Xamarin.Firebase.Encoders.JSON => 0xc9ad4f38 => 267
	i32 3395150330, ; 537: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 100
	i32 3403906625, ; 538: System.Security.Cryptography.OpenSsl.dll => 0xcae37e41 => 122
	i32 3405233483, ; 539: Xamarin.AndroidX.CustomView.PoolingContainer => 0xcaf7bd4b => 216
	i32 3428513518, ; 540: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 176
	i32 3429136800, ; 541: System.Xml => 0xcc6479a0 => 162
	i32 3430777524, ; 542: netstandard => 0xcc7d82b4 => 166
	i32 3441283291, ; 543: Xamarin.AndroidX.DynamicAnimation.dll => 0xcd1dd0db => 219
	i32 3445260447, ; 544: System.Formats.Tar => 0xcd5a809f => 38
	i32 3452344032, ; 545: Microsoft.Maui.Controls.Compatibility.dll => 0xcdc696e0 => 183
	i32 3463511458, ; 546: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 306
	i32 3471940407, ; 547: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 17
	i32 3476120550, ; 548: Mono.Android => 0xcf3163e6 => 170
	i32 3479583265, ; 549: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 319
	i32 3484440000, ; 550: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 318
	i32 3485117614, ; 551: System.Text.Json.dll => 0xcfbaacae => 136
	i32 3486566296, ; 552: System.Transactions => 0xcfd0c798 => 149
	i32 3493954962, ; 553: Xamarin.AndroidX.Concurrent.Futures.dll => 0xd0418592 => 208
	i32 3509114376, ; 554: System.Xml.Linq => 0xd128d608 => 154
	i32 3515174580, ; 555: System.Security.dll => 0xd1854eb4 => 129
	i32 3530912306, ; 556: System.Configuration => 0xd2757232 => 19
	i32 3539954161, ; 557: System.Net.HttpListener => 0xd2ff69f1 => 64
	i32 3560100363, ; 558: System.Threading.Timer => 0xd432d20b => 146
	i32 3570554715, ; 559: System.IO.FileSystem.AccessControl => 0xd4d2575b => 46
	i32 3580758918, ; 560: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 326
	i32 3581607451, ; 561: PriceTrackerApp => 0xd57afe1b => 0
	i32 3597029428, ; 562: Xamarin.Android.Glide.GifDecoder.dll => 0xd6665034 => 194
	i32 3598340787, ; 563: System.Net.WebSockets.Client => 0xd67a52b3 => 78
	i32 3608519521, ; 564: System.Linq.dll => 0xd715a361 => 60
	i32 3624195450, ; 565: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 105
	i32 3627220390, ; 566: Xamarin.AndroidX.Print.dll => 0xd832fda6 => 243
	i32 3633644679, ; 567: Xamarin.AndroidX.Annotation.Experimental => 0xd8950487 => 198
	i32 3638274909, ; 568: System.IO.FileSystem.Primitives.dll => 0xd8dbab5d => 48
	i32 3641597786, ; 569: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 229
	i32 3643446276, ; 570: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 323
	i32 3643854240, ; 571: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 240
	i32 3645089577, ; 572: System.ComponentModel.DataAnnotations => 0xd943a729 => 14
	i32 3657292374, ; 573: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 175
	i32 3660523487, ; 574: System.Net.NetworkInformation => 0xda2f27df => 67
	i32 3672681054, ; 575: Mono.Android.dll => 0xdae8aa5e => 170
	i32 3682565725, ; 576: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 204
	i32 3684561358, ; 577: Xamarin.AndroidX.Concurrent.Futures => 0xdb9df1ce => 208
	i32 3697841164, ; 578: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 328
	i32 3700866549, ; 579: System.Net.WebProxy.dll => 0xdc96bdf5 => 77
	i32 3706696989, ; 580: Xamarin.AndroidX.Core.Core.Ktx.dll => 0xdcefb51d => 213
	i32 3716563718, ; 581: System.Runtime.Intrinsics => 0xdd864306 => 107
	i32 3718780102, ; 582: Xamarin.AndroidX.Annotation => 0xdda814c6 => 197
	i32 3724971120, ; 583: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 239
	i32 3732100267, ; 584: System.Net.NameResolution => 0xde7354ab => 66
	i32 3737834244, ; 585: System.Net.Http.Json.dll => 0xdecad304 => 62
	i32 3748608112, ; 586: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 190
	i32 3751444290, ; 587: System.Xml.XPath => 0xdf9a7f42 => 159
	i32 3786282454, ; 588: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 206
	i32 3792276235, ; 589: System.Collections.NonGeneric => 0xe2098b0b => 10
	i32 3800979733, ; 590: Microsoft.Maui.Controls.Compatibility => 0xe28e5915 => 183
	i32 3802395368, ; 591: System.Collections.Specialized.dll => 0xe2a3f2e8 => 11
	i32 3810220126, ; 592: HtmlAgilityPack.dll => 0xe31b585e => 173
	i32 3819260425, ; 593: System.Net.WebProxy => 0xe3a54a09 => 77
	i32 3823082795, ; 594: System.Security.Cryptography.dll => 0xe3df9d2b => 125
	i32 3829621856, ; 595: System.Numerics.dll => 0xe4436460 => 82
	i32 3841636137, ; 596: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 177
	i32 3844307129, ; 597: System.Net.Mail.dll => 0xe52378b9 => 65
	i32 3849253459, ; 598: System.Runtime.InteropServices.dll => 0xe56ef253 => 106
	i32 3870376305, ; 599: System.Net.HttpListener.dll => 0xe6b14171 => 64
	i32 3873536506, ; 600: System.Security.Principal => 0xe6e179fa => 127
	i32 3875112723, ; 601: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 121
	i32 3885497537, ; 602: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 76
	i32 3885922214, ; 603: Xamarin.AndroidX.Transition.dll => 0xe79e77a6 => 254
	i32 3888767677, ; 604: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0xe7c9e2bd => 244
	i32 3889960447, ; 605: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 327
	i32 3896106733, ; 606: System.Collections.Concurrent.dll => 0xe839deed => 8
	i32 3896760992, ; 607: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 212
	i32 3901907137, ; 608: Microsoft.VisualBasic.Core.dll => 0xe89260c1 => 2
	i32 3920810846, ; 609: System.IO.Compression.FileSystem.dll => 0xe9b2d35e => 43
	i32 3921031405, ; 610: Xamarin.AndroidX.VersionedParcelable.dll => 0xe9b630ed => 257
	i32 3928044579, ; 611: System.Xml.ReaderWriter => 0xea213423 => 155
	i32 3930554604, ; 612: System.Security.Principal.dll => 0xea4780ec => 127
	i32 3931092270, ; 613: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 242
	i32 3934056515, ; 614: Xamarin.JavaX.Inject.dll => 0xea7cf043 => 287
	i32 3945713374, ; 615: System.Data.DataSetExtensions.dll => 0xeb2ecede => 23
	i32 3953953790, ; 616: System.Text.Encoding.CodePages => 0xebac8bfe => 132
	i32 3955647286, ; 617: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 200
	i32 3959773229, ; 618: Xamarin.AndroidX.Lifecycle.Process => 0xec05582d => 231
	i32 3970018735, ; 619: Xamarin.GooglePlayServices.Tasks.dll => 0xeca1adaf => 286
	i32 3980434154, ; 620: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 322
	i32 3987592930, ; 621: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 304
	i32 4003436829, ; 622: System.Diagnostics.Process.dll => 0xee9f991d => 28
	i32 4015948917, ; 623: Xamarin.AndroidX.Annotation.Jvm.dll => 0xef5e8475 => 199
	i32 4025784931, ; 624: System.Memory => 0xeff49a63 => 61
	i32 4046471985, ; 625: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 185
	i32 4054681211, ; 626: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 89
	i32 4068434129, ; 627: System.Private.Xml.Linq.dll => 0xf27f60d1 => 86
	i32 4073602200, ; 628: System.Threading.dll => 0xf2ce3c98 => 147
	i32 4094352644, ; 629: Microsoft.Maui.Essentials.dll => 0xf40add04 => 187
	i32 4099507663, ; 630: System.Drawing.dll => 0xf45985cf => 35
	i32 4100113165, ; 631: System.Private.Uri => 0xf462c30d => 85
	i32 4101593132, ; 632: Xamarin.AndroidX.Emoji2 => 0xf479582c => 220
	i32 4102112229, ; 633: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 317
	i32 4125707920, ; 634: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 312
	i32 4126470640, ; 635: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 176
	i32 4127667938, ; 636: System.IO.FileSystem.Watcher => 0xf60736e2 => 49
	i32 4130442656, ; 637: System.AppContext => 0xf6318da0 => 6
	i32 4147896353, ; 638: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 89
	i32 4150914736, ; 639: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 324
	i32 4151237749, ; 640: System.Core => 0xf76edc75 => 21
	i32 4159265925, ; 641: System.Xml.XmlSerializer => 0xf7e95c85 => 161
	i32 4161255271, ; 642: System.Reflection.TypeExtensions => 0xf807b767 => 95
	i32 4164802419, ; 643: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 49
	i32 4181436372, ; 644: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 112
	i32 4182413190, ; 645: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 236
	i32 4185676441, ; 646: System.Security => 0xf97c5a99 => 129
	i32 4192648326, ; 647: Xamarin.Firebase.Encoders.JSON.dll => 0xf9e6bc86 => 267
	i32 4196529839, ; 648: System.Net.WebClient.dll => 0xfa21f6af => 75
	i32 4213026141, ; 649: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 190
	i32 4256097574, ; 650: Xamarin.AndroidX.Core.Core.Ktx => 0xfdaee526 => 213
	i32 4258378803, ; 651: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xfdd1b433 => 235
	i32 4259717024, ; 652: PriceTrackerApp.dll => 0xfde61fa0 => 0
	i32 4260525087, ; 653: System.Buffers => 0xfdf2741f => 7
	i32 4269159614, ; 654: Xamarin.Firebase.Datatransport => 0xfe7634be => 265
	i32 4271975918, ; 655: Microsoft.Maui.Controls.dll => 0xfea12dee => 184
	i32 4274976490, ; 656: System.Runtime.Numerics => 0xfecef6ea => 109
	i32 4284549794, ; 657: Xamarin.Firebase.Components => 0xff610aa2 => 264
	i32 4292120959, ; 658: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 236
	i32 4294763496 ; 659: Xamarin.AndroidX.ExifInterface.dll => 0xfffce3e8 => 222
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [660 x i32] [
	i32 67, ; 0
	i32 66, ; 1
	i32 107, ; 2
	i32 232, ; 3
	i32 281, ; 4
	i32 47, ; 5
	i32 189, ; 6
	i32 79, ; 7
	i32 144, ; 8
	i32 173, ; 9
	i32 29, ; 10
	i32 328, ; 11
	i32 123, ; 12
	i32 188, ; 13
	i32 101, ; 14
	i32 250, ; 15
	i32 262, ; 16
	i32 106, ; 17
	i32 250, ; 18
	i32 138, ; 19
	i32 291, ; 20
	i32 76, ; 21
	i32 123, ; 22
	i32 13, ; 23
	i32 206, ; 24
	i32 131, ; 25
	i32 252, ; 26
	i32 150, ; 27
	i32 325, ; 28
	i32 326, ; 29
	i32 18, ; 30
	i32 204, ; 31
	i32 26, ; 32
	i32 226, ; 33
	i32 1, ; 34
	i32 58, ; 35
	i32 41, ; 36
	i32 90, ; 37
	i32 209, ; 38
	i32 146, ; 39
	i32 228, ; 40
	i32 225, ; 41
	i32 297, ; 42
	i32 53, ; 43
	i32 68, ; 44
	i32 325, ; 45
	i32 195, ; 46
	i32 82, ; 47
	i32 310, ; 48
	i32 227, ; 49
	i32 309, ; 50
	i32 130, ; 51
	i32 54, ; 52
	i32 148, ; 53
	i32 73, ; 54
	i32 144, ; 55
	i32 61, ; 56
	i32 145, ; 57
	i32 329, ; 58
	i32 164, ; 59
	i32 321, ; 60
	i32 210, ; 61
	i32 12, ; 62
	i32 223, ; 63
	i32 124, ; 64
	i32 151, ; 65
	i32 112, ; 66
	i32 165, ; 67
	i32 163, ; 68
	i32 225, ; 69
	i32 276, ; 70
	i32 238, ; 71
	i32 276, ; 72
	i32 83, ; 73
	i32 308, ; 74
	i32 302, ; 75
	i32 274, ; 76
	i32 182, ; 77
	i32 149, ; 78
	i32 291, ; 79
	i32 59, ; 80
	i32 178, ; 81
	i32 50, ; 82
	i32 285, ; 83
	i32 102, ; 84
	i32 113, ; 85
	i32 39, ; 86
	i32 278, ; 87
	i32 261, ; 88
	i32 119, ; 89
	i32 316, ; 90
	i32 51, ; 91
	i32 43, ; 92
	i32 118, ; 93
	i32 215, ; 94
	i32 314, ; 95
	i32 221, ; 96
	i32 80, ; 97
	i32 135, ; 98
	i32 257, ; 99
	i32 202, ; 100
	i32 8, ; 101
	i32 72, ; 102
	i32 296, ; 103
	i32 154, ; 104
	i32 293, ; 105
	i32 153, ; 106
	i32 91, ; 107
	i32 288, ; 108
	i32 44, ; 109
	i32 311, ; 110
	i32 299, ; 111
	i32 292, ; 112
	i32 108, ; 113
	i32 128, ; 114
	i32 25, ; 115
	i32 192, ; 116
	i32 71, ; 117
	i32 54, ; 118
	i32 45, ; 119
	i32 320, ; 120
	i32 181, ; 121
	i32 216, ; 122
	i32 22, ; 123
	i32 230, ; 124
	i32 85, ; 125
	i32 42, ; 126
	i32 159, ; 127
	i32 70, ; 128
	i32 243, ; 129
	i32 270, ; 130
	i32 3, ; 131
	i32 41, ; 132
	i32 62, ; 133
	i32 271, ; 134
	i32 16, ; 135
	i32 52, ; 136
	i32 323, ; 137
	i32 281, ; 138
	i32 104, ; 139
	i32 189, ; 140
	i32 292, ; 141
	i32 279, ; 142
	i32 227, ; 143
	i32 33, ; 144
	i32 157, ; 145
	i32 84, ; 146
	i32 31, ; 147
	i32 12, ; 148
	i32 50, ; 149
	i32 275, ; 150
	i32 55, ; 151
	i32 247, ; 152
	i32 35, ; 153
	i32 177, ; 154
	i32 298, ; 155
	i32 280, ; 156
	i32 200, ; 157
	i32 284, ; 158
	i32 34, ; 159
	i32 57, ; 160
	i32 234, ; 161
	i32 172, ; 162
	i32 17, ; 163
	i32 289, ; 164
	i32 163, ; 165
	i32 311, ; 166
	i32 233, ; 167
	i32 180, ; 168
	i32 272, ; 169
	i32 260, ; 170
	i32 317, ; 171
	i32 152, ; 172
	i32 256, ; 173
	i32 241, ; 174
	i32 315, ; 175
	i32 202, ; 176
	i32 28, ; 177
	i32 51, ; 178
	i32 313, ; 179
	i32 261, ; 180
	i32 5, ; 181
	i32 297, ; 182
	i32 251, ; 183
	i32 255, ; 184
	i32 207, ; 185
	i32 293, ; 186
	i32 199, ; 187
	i32 218, ; 188
	i32 84, ; 189
	i32 260, ; 190
	i32 60, ; 191
	i32 263, ; 192
	i32 111, ; 193
	i32 56, ; 194
	i32 327, ; 195
	i32 247, ; 196
	i32 98, ; 197
	i32 287, ; 198
	i32 19, ; 199
	i32 211, ; 200
	i32 110, ; 201
	i32 100, ; 202
	i32 101, ; 203
	i32 295, ; 204
	i32 103, ; 205
	i32 279, ; 206
	i32 70, ; 207
	i32 37, ; 208
	i32 31, ; 209
	i32 102, ; 210
	i32 72, ; 211
	i32 301, ; 212
	i32 9, ; 213
	i32 122, ; 214
	i32 45, ; 215
	i32 201, ; 216
	i32 182, ; 217
	i32 9, ; 218
	i32 42, ; 219
	i32 4, ; 220
	i32 248, ; 221
	i32 305, ; 222
	i32 300, ; 223
	i32 269, ; 224
	i32 30, ; 225
	i32 137, ; 226
	i32 91, ; 227
	i32 92, ; 228
	i32 320, ; 229
	i32 48, ; 230
	i32 140, ; 231
	i32 111, ; 232
	i32 139, ; 233
	i32 217, ; 234
	i32 114, ; 235
	i32 280, ; 236
	i32 156, ; 237
	i32 75, ; 238
	i32 78, ; 239
	i32 237, ; 240
	i32 36, ; 241
	i32 259, ; 242
	i32 221, ; 243
	i32 214, ; 244
	i32 63, ; 245
	i32 137, ; 246
	i32 15, ; 247
	i32 115, ; 248
	i32 253, ; 249
	i32 277, ; 250
	i32 209, ; 251
	i32 47, ; 252
	i32 69, ; 253
	i32 79, ; 254
	i32 125, ; 255
	i32 93, ; 256
	i32 120, ; 257
	i32 290, ; 258
	i32 26, ; 259
	i32 230, ; 260
	i32 96, ; 261
	i32 27, ; 262
	i32 205, ; 263
	i32 318, ; 264
	i32 296, ; 265
	i32 148, ; 266
	i32 168, ; 267
	i32 4, ; 268
	i32 97, ; 269
	i32 32, ; 270
	i32 92, ; 271
	i32 252, ; 272
	i32 178, ; 273
	i32 21, ; 274
	i32 40, ; 275
	i32 169, ; 276
	i32 312, ; 277
	i32 223, ; 278
	i32 304, ; 279
	i32 237, ; 280
	i32 289, ; 281
	i32 277, ; 282
	i32 242, ; 283
	i32 2, ; 284
	i32 133, ; 285
	i32 110, ; 286
	i32 179, ; 287
	i32 324, ; 288
	i32 192, ; 289
	i32 321, ; 290
	i32 57, ; 291
	i32 94, ; 292
	i32 303, ; 293
	i32 268, ; 294
	i32 38, ; 295
	i32 203, ; 296
	i32 25, ; 297
	i32 93, ; 298
	i32 88, ; 299
	i32 98, ; 300
	i32 283, ; 301
	i32 10, ; 302
	i32 273, ; 303
	i32 86, ; 304
	i32 99, ; 305
	i32 249, ; 306
	i32 174, ; 307
	i32 290, ; 308
	i32 194, ; 309
	i32 300, ; 310
	i32 7, ; 311
	i32 234, ; 312
	i32 295, ; 313
	i32 191, ; 314
	i32 87, ; 315
	i32 229, ; 316
	i32 153, ; 317
	i32 299, ; 318
	i32 32, ; 319
	i32 115, ; 320
	i32 81, ; 321
	i32 275, ; 322
	i32 20, ; 323
	i32 282, ; 324
	i32 11, ; 325
	i32 161, ; 326
	i32 3, ; 327
	i32 186, ; 328
	i32 307, ; 329
	i32 262, ; 330
	i32 181, ; 331
	i32 179, ; 332
	i32 83, ; 333
	i32 294, ; 334
	i32 63, ; 335
	i32 309, ; 336
	i32 256, ; 337
	i32 142, ; 338
	i32 238, ; 339
	i32 156, ; 340
	i32 40, ; 341
	i32 116, ; 342
	i32 175, ; 343
	i32 193, ; 344
	i32 303, ; 345
	i32 245, ; 346
	i32 130, ; 347
	i32 74, ; 348
	i32 65, ; 349
	i32 313, ; 350
	i32 171, ; 351
	i32 197, ; 352
	i32 142, ; 353
	i32 105, ; 354
	i32 150, ; 355
	i32 69, ; 356
	i32 155, ; 357
	i32 174, ; 358
	i32 120, ; 359
	i32 126, ; 360
	i32 308, ; 361
	i32 151, ; 362
	i32 220, ; 363
	i32 140, ; 364
	i32 207, ; 365
	i32 305, ; 366
	i32 20, ; 367
	i32 14, ; 368
	i32 134, ; 369
	i32 74, ; 370
	i32 58, ; 371
	i32 210, ; 372
	i32 166, ; 373
	i32 167, ; 374
	i32 184, ; 375
	i32 272, ; 376
	i32 273, ; 377
	i32 15, ; 378
	i32 73, ; 379
	i32 284, ; 380
	i32 6, ; 381
	i32 23, ; 382
	i32 232, ; 383
	i32 191, ; 384
	i32 90, ; 385
	i32 306, ; 386
	i32 1, ; 387
	i32 135, ; 388
	i32 233, ; 389
	i32 255, ; 390
	i32 133, ; 391
	i32 68, ; 392
	i32 145, ; 393
	i32 315, ; 394
	i32 294, ; 395
	i32 224, ; 396
	i32 180, ; 397
	i32 87, ; 398
	i32 95, ; 399
	i32 266, ; 400
	i32 214, ; 401
	i32 271, ; 402
	i32 219, ; 403
	i32 310, ; 404
	i32 30, ; 405
	i32 44, ; 406
	i32 228, ; 407
	i32 266, ; 408
	i32 193, ; 409
	i32 108, ; 410
	i32 157, ; 411
	i32 34, ; 412
	i32 22, ; 413
	i32 113, ; 414
	i32 56, ; 415
	i32 253, ; 416
	i32 143, ; 417
	i32 117, ; 418
	i32 119, ; 419
	i32 109, ; 420
	i32 195, ; 421
	i32 138, ; 422
	i32 201, ; 423
	i32 53, ; 424
	i32 104, ; 425
	i32 316, ; 426
	i32 185, ; 427
	i32 186, ; 428
	i32 132, ; 429
	i32 288, ; 430
	i32 258, ; 431
	i32 246, ; 432
	i32 322, ; 433
	i32 224, ; 434
	i32 188, ; 435
	i32 158, ; 436
	i32 264, ; 437
	i32 301, ; 438
	i32 211, ; 439
	i32 162, ; 440
	i32 131, ; 441
	i32 246, ; 442
	i32 160, ; 443
	i32 314, ; 444
	i32 235, ; 445
	i32 282, ; 446
	i32 139, ; 447
	i32 258, ; 448
	i32 254, ; 449
	i32 168, ; 450
	i32 187, ; 451
	i32 196, ; 452
	i32 278, ; 453
	i32 39, ; 454
	i32 270, ; 455
	i32 222, ; 456
	i32 80, ; 457
	i32 55, ; 458
	i32 36, ; 459
	i32 96, ; 460
	i32 165, ; 461
	i32 171, ; 462
	i32 269, ; 463
	i32 259, ; 464
	i32 81, ; 465
	i32 198, ; 466
	i32 97, ; 467
	i32 29, ; 468
	i32 158, ; 469
	i32 18, ; 470
	i32 126, ; 471
	i32 118, ; 472
	i32 218, ; 473
	i32 249, ; 474
	i32 231, ; 475
	i32 251, ; 476
	i32 164, ; 477
	i32 226, ; 478
	i32 329, ; 479
	i32 248, ; 480
	i32 239, ; 481
	i32 286, ; 482
	i32 169, ; 483
	i32 16, ; 484
	i32 263, ; 485
	i32 143, ; 486
	i32 307, ; 487
	i32 124, ; 488
	i32 117, ; 489
	i32 37, ; 490
	i32 265, ; 491
	i32 114, ; 492
	i32 46, ; 493
	i32 141, ; 494
	i32 116, ; 495
	i32 33, ; 496
	i32 172, ; 497
	i32 274, ; 498
	i32 94, ; 499
	i32 52, ; 500
	i32 240, ; 501
	i32 128, ; 502
	i32 152, ; 503
	i32 24, ; 504
	i32 160, ; 505
	i32 217, ; 506
	i32 147, ; 507
	i32 103, ; 508
	i32 283, ; 509
	i32 88, ; 510
	i32 205, ; 511
	i32 59, ; 512
	i32 141, ; 513
	i32 99, ; 514
	i32 5, ; 515
	i32 13, ; 516
	i32 121, ; 517
	i32 134, ; 518
	i32 27, ; 519
	i32 302, ; 520
	i32 71, ; 521
	i32 215, ; 522
	i32 24, ; 523
	i32 285, ; 524
	i32 203, ; 525
	i32 244, ; 526
	i32 241, ; 527
	i32 319, ; 528
	i32 136, ; 529
	i32 196, ; 530
	i32 212, ; 531
	i32 167, ; 532
	i32 268, ; 533
	i32 245, ; 534
	i32 298, ; 535
	i32 267, ; 536
	i32 100, ; 537
	i32 122, ; 538
	i32 216, ; 539
	i32 176, ; 540
	i32 162, ; 541
	i32 166, ; 542
	i32 219, ; 543
	i32 38, ; 544
	i32 183, ; 545
	i32 306, ; 546
	i32 17, ; 547
	i32 170, ; 548
	i32 319, ; 549
	i32 318, ; 550
	i32 136, ; 551
	i32 149, ; 552
	i32 208, ; 553
	i32 154, ; 554
	i32 129, ; 555
	i32 19, ; 556
	i32 64, ; 557
	i32 146, ; 558
	i32 46, ; 559
	i32 326, ; 560
	i32 0, ; 561
	i32 194, ; 562
	i32 78, ; 563
	i32 60, ; 564
	i32 105, ; 565
	i32 243, ; 566
	i32 198, ; 567
	i32 48, ; 568
	i32 229, ; 569
	i32 323, ; 570
	i32 240, ; 571
	i32 14, ; 572
	i32 175, ; 573
	i32 67, ; 574
	i32 170, ; 575
	i32 204, ; 576
	i32 208, ; 577
	i32 328, ; 578
	i32 77, ; 579
	i32 213, ; 580
	i32 107, ; 581
	i32 197, ; 582
	i32 239, ; 583
	i32 66, ; 584
	i32 62, ; 585
	i32 190, ; 586
	i32 159, ; 587
	i32 206, ; 588
	i32 10, ; 589
	i32 183, ; 590
	i32 11, ; 591
	i32 173, ; 592
	i32 77, ; 593
	i32 125, ; 594
	i32 82, ; 595
	i32 177, ; 596
	i32 65, ; 597
	i32 106, ; 598
	i32 64, ; 599
	i32 127, ; 600
	i32 121, ; 601
	i32 76, ; 602
	i32 254, ; 603
	i32 244, ; 604
	i32 327, ; 605
	i32 8, ; 606
	i32 212, ; 607
	i32 2, ; 608
	i32 43, ; 609
	i32 257, ; 610
	i32 155, ; 611
	i32 127, ; 612
	i32 242, ; 613
	i32 287, ; 614
	i32 23, ; 615
	i32 132, ; 616
	i32 200, ; 617
	i32 231, ; 618
	i32 286, ; 619
	i32 322, ; 620
	i32 304, ; 621
	i32 28, ; 622
	i32 199, ; 623
	i32 61, ; 624
	i32 185, ; 625
	i32 89, ; 626
	i32 86, ; 627
	i32 147, ; 628
	i32 187, ; 629
	i32 35, ; 630
	i32 85, ; 631
	i32 220, ; 632
	i32 317, ; 633
	i32 312, ; 634
	i32 176, ; 635
	i32 49, ; 636
	i32 6, ; 637
	i32 89, ; 638
	i32 324, ; 639
	i32 21, ; 640
	i32 161, ; 641
	i32 95, ; 642
	i32 49, ; 643
	i32 112, ; 644
	i32 236, ; 645
	i32 129, ; 646
	i32 267, ; 647
	i32 75, ; 648
	i32 190, ; 649
	i32 213, ; 650
	i32 235, ; 651
	i32 0, ; 652
	i32 7, ; 653
	i32 265, ; 654
	i32 184, ; 655
	i32 109, ; 656
	i32 264, ; 657
	i32 236, ; 658
	i32 222 ; 659
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
