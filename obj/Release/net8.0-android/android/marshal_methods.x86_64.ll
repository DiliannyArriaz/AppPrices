; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [140 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [280 x i64] [
	i64 98382396393917666, ; 0: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 43
	i64 120698629574877762, ; 1: Mono.Android => 0x1accec39cafe242 => 139
	i64 131669012237370309, ; 2: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 47
	i64 196720943101637631, ; 3: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 97
	i64 210515253464952879, ; 4: Xamarin.AndroidX.Collection.dll => 0x2ebe681f694702f => 55
	i64 232391251801502327, ; 5: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 72
	i64 545109961164950392, ; 6: fi/Microsoft.Maui.Controls.resources.dll => 0x7909e9f1ec38b78 => 7
	i64 560278790331054453, ; 7: System.Reflection.Primitives => 0x7c6829760de3975 => 117
	i64 750875890346172408, ; 8: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 129
	i64 799765834175365804, ; 9: System.ComponentModel.dll => 0xb1956c9f18442ac => 88
	i64 849051935479314978, ; 10: hi/Microsoft.Maui.Controls.resources.dll => 0xbc8703ca21a3a22 => 10
	i64 872800313462103108, ; 11: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 60
	i64 964003131647442271, ; 12: HtmlAgilityPack => 0xd60d3bda035bd5f => 35
	i64 1010599046655515943, ; 13: System.Reflection.Primitives.dll => 0xe065e7a82401d27 => 117
	i64 1120440138749646132, ; 14: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 77
	i64 1121665720830085036, ; 15: nb/Microsoft.Maui.Controls.resources.dll => 0xf90f507becf47ac => 18
	i64 1268860745194512059, ; 16: System.Drawing.dll => 0x119be62002c19ebb => 93
	i64 1369545283391376210, ; 17: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 68
	i64 1476839205573959279, ; 18: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 103
	i64 1486715745332614827, ; 19: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 44
	i64 1513467482682125403, ; 20: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 138
	i64 1537168428375924959, ; 21: System.Threading.Thread.dll => 0x15551e8a954ae0df => 129
	i64 1556147632182429976, ; 22: ko/Microsoft.Maui.Controls.resources.dll => 0x15988c06d24c8918 => 16
	i64 1624659445732251991, ; 23: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 53
	i64 1628611045998245443, ; 24: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 65
	i64 1731380447121279447, ; 25: Newtonsoft.Json => 0x18071957e9b889d7 => 49
	i64 1743969030606105336, ; 26: System.Memory.dll => 0x1833d297e88f2af8 => 99
	i64 1767386781656293639, ; 27: System.Private.Uri.dll => 0x188704e9f5582107 => 112
	i64 1795316252682057001, ; 28: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 52
	i64 1835311033149317475, ; 29: es\Microsoft.Maui.Controls.resources => 0x197855a927386163 => 6
	i64 1836611346387731153, ; 30: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 72
	i64 1875417405349196092, ; 31: System.Drawing.Primitives => 0x1a06d2319b6c713c => 92
	i64 1881198190668717030, ; 32: tr\Microsoft.Maui.Controls.resources => 0x1a1b5bc992ea9be6 => 28
	i64 1920760634179481754, ; 33: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 45
	i64 1959996714666907089, ; 34: tr/Microsoft.Maui.Controls.resources.dll => 0x1b334ea0a2a755d1 => 28
	i64 1981742497975770890, ; 35: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 64
	i64 1983698669889758782, ; 36: cs/Microsoft.Maui.Controls.resources.dll => 0x1b87836e2031a63e => 2
	i64 2019660174692588140, ; 37: pl/Microsoft.Maui.Controls.resources.dll => 0x1c07463a6f8e1a6c => 20
	i64 2102659300918482391, ; 38: System.Drawing.Primitives.dll => 0x1d2e257e6aead5d7 => 92
	i64 2133195048986300728, ; 39: Newtonsoft.Json.dll => 0x1d9aa1984b735138 => 49
	i64 2262844636196693701, ; 40: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 60
	i64 2287834202362508563, ; 41: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 82
	i64 2302323944321350744, ; 42: ru/Microsoft.Maui.Controls.resources.dll => 0x1ff37f6ddb267c58 => 24
	i64 2329709569556905518, ; 43: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 63
	i64 2470498323731680442, ; 44: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 56
	i64 2497223385847772520, ; 45: System.Runtime => 0x22a7eb7046413568 => 123
	i64 2547086958574651984, ; 46: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 51
	i64 2602673633151553063, ; 47: th\Microsoft.Maui.Controls.resources => 0x241e8de13a460e27 => 27
	i64 2632269733008246987, ; 48: System.Net.NameResolution => 0x2487b36034f808cb => 101
	i64 2656907746661064104, ; 49: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 38
	i64 2662981627730767622, ; 50: cs\Microsoft.Maui.Controls.resources => 0x24f4cfae6c48af06 => 2
	i64 2895129759130297543, ; 51: fi\Microsoft.Maui.Controls.resources => 0x282d912d479fa4c7 => 7
	i64 3017136373564924869, ; 52: System.Net.WebProxy => 0x29df058bd93f63c5 => 109
	i64 3017704767998173186, ; 53: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 77
	i64 3289520064315143713, ; 54: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 62
	i64 3311221304742556517, ; 55: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 110
	i64 3325875462027654285, ; 56: System.Runtime.Numerics => 0x2e27e21c8958b48d => 120
	i64 3328853167529574890, ; 57: System.Net.Sockets.dll => 0x2e327651a008c1ea => 107
	i64 3344514922410554693, ; 58: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 79
	i64 3397747728761535915, ; 59: HtmlAgilityPack.dll => 0x2f27398ea938bdab => 35
	i64 3429672777697402584, ; 60: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 47
	i64 3494946837667399002, ; 61: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 36
	i64 3522470458906976663, ; 62: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 73
	i64 3551103847008531295, ; 63: System.Private.CoreLib.dll => 0x31480e226177735f => 136
	i64 3567343442040498961, ; 64: pt\Microsoft.Maui.Controls.resources => 0x3181bff5bea4ab11 => 22
	i64 3571415421602489686, ; 65: System.Runtime.dll => 0x319037675df7e556 => 123
	i64 3638003163729360188, ; 66: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 37
	i64 3647754201059316852, ; 67: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 132
	i64 3655542548057982301, ; 68: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 36
	i64 3716579019761409177, ; 69: netstandard.dll => 0x3393f0ed5c8c5c99 => 135
	i64 3727469159507183293, ; 70: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 71
	i64 3869221888984012293, ; 71: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 40
	i64 3890352374528606784, ; 72: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 45
	i64 3933965368022646939, ; 73: System.Net.Requests => 0x369840a8bfadc09b => 104
	i64 3966267475168208030, ; 74: System.Memory => 0x370b03412596249e => 99
	i64 4009997192427317104, ; 75: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 122
	i64 4073500526318903918, ; 76: System.Private.Xml.dll => 0x3887fb25779ae26e => 114
	i64 4120493066591692148, ; 77: zh-Hant\Microsoft.Maui.Controls.resources => 0x392eee9cdda86574 => 33
	i64 4154383907710350974, ; 78: System.ComponentModel => 0x39a7562737acb67e => 88
	i64 4187479170553454871, ; 79: System.Linq.Expressions => 0x3a1cea1e912fa117 => 97
	i64 4205801962323029395, ; 80: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 87
	i64 4356591372459378815, ; 81: vi/Microsoft.Maui.Controls.resources.dll => 0x3c75b8c562f9087f => 30
	i64 4636684751163556186, ; 82: Xamarin.AndroidX.VersionedParcelable.dll => 0x4058d0370893015a => 74
	i64 4679594760078841447, ; 83: ar/Microsoft.Maui.Controls.resources.dll => 0x40f142a407475667 => 0
	i64 4794310189461587505, ; 84: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 51
	i64 4795410492532947900, ; 85: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 73
	i64 4809057822547766521, ; 86: System.Drawing => 0x42bd349c3145ecf9 => 93
	i64 4814660307502931973, ; 87: System.Net.NameResolution.dll => 0x42d11c0a5ee2a005 => 101
	i64 4853321196694829351, ; 88: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 119
	i64 5103417709280584325, ; 89: System.Collections.Specialized => 0x46d2fb5e161b6285 => 84
	i64 5182934613077526976, ; 90: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 84
	i64 5290786973231294105, ; 91: System.Runtime.Loader => 0x496ca6b869b72699 => 119
	i64 5471532531798518949, ; 92: sv\Microsoft.Maui.Controls.resources => 0x4beec9d926d82ca5 => 26
	i64 5522859530602327440, ; 93: uk\Microsoft.Maui.Controls.resources => 0x4ca5237b51eead90 => 29
	i64 5570799893513421663, ; 94: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 95
	i64 5573260873512690141, ; 95: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 124
	i64 5692067934154308417, ; 96: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 76
	i64 5979151488806146654, ; 97: System.Formats.Asn1 => 0x52fa3699a489d25e => 94
	i64 6068057819846744445, ; 98: ro/Microsoft.Maui.Controls.resources.dll => 0x5436126fec7f197d => 23
	i64 6200764641006662125, ; 99: ro\Microsoft.Maui.Controls.resources => 0x560d8a96830131ed => 23
	i64 6222399776351216807, ; 100: System.Text.Json.dll => 0x565a67a0ffe264a7 => 126
	i64 6284145129771520194, ; 101: System.Reflection.Emit.ILGeneration => 0x5735c4b3610850c2 => 115
	i64 6357457916754632952, ; 102: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 34
	i64 6401687960814735282, ; 103: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 63
	i64 6478287442656530074, ; 104: hr\Microsoft.Maui.Controls.resources => 0x59e7801b0c6a8e9a => 11
	i64 6548213210057960872, ; 105: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 59
	i64 6560151584539558821, ; 106: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 42
	i64 6743165466166707109, ; 107: nl\Microsoft.Maui.Controls.resources => 0x5d948943c08c43a5 => 19
	i64 6777482997383978746, ; 108: pt/Microsoft.Maui.Controls.resources.dll => 0x5e0e74e0a2525efa => 22
	i64 6786606130239981554, ; 109: System.Diagnostics.TraceSource => 0x5e2ede51877147f2 => 91
	i64 6814185388980153342, ; 110: System.Xml.XDocument.dll => 0x5e90d98217d1abfe => 133
	i64 6876862101832370452, ; 111: System.Xml.Linq => 0x5f6f85a57d108914 => 131
	i64 6894844156784520562, ; 112: System.Numerics.Vectors => 0x5faf683aead1ad72 => 110
	i64 7083547580668757502, ; 113: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 113
	i64 7220009545223068405, ; 114: sv/Microsoft.Maui.Controls.resources.dll => 0x6432a06d99f35af5 => 26
	i64 7270811800166795866, ; 115: System.Linq => 0x64e71ccf51a90a5a => 98
	i64 7377312882064240630, ; 116: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 87
	i64 7488575175965059935, ; 117: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 131
	i64 7489048572193775167, ; 118: System.ObjectModel => 0x67ee71ff6b419e3f => 111
	i64 7654504624184590948, ; 119: System.Net.Http => 0x6a3a4366801b8264 => 100
	i64 7708790323521193081, ; 120: ms/Microsoft.Maui.Controls.resources.dll => 0x6afb1ff4d1730479 => 17
	i64 7714652370974252055, ; 121: System.Private.CoreLib => 0x6b0ff375198b9c17 => 136
	i64 7735176074855944702, ; 122: Microsoft.CSharp => 0x6b58dda848e391fe => 81
	i64 7735352534559001595, ; 123: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 78
	i64 7836164640616011524, ; 124: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 53
	i64 8064050204834738623, ; 125: System.Collections.dll => 0x6fe942efa61731bf => 85
	i64 8083354569033831015, ; 126: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 62
	i64 8087206902342787202, ; 127: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 50
	i64 8167236081217502503, ; 128: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 137
	i64 8185542183669246576, ; 129: System.Collections => 0x7198e33f4794aa70 => 85
	i64 8246048515196606205, ; 130: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 48
	i64 8368701292315763008, ; 131: System.Security.Cryptography => 0x7423997c6fd56140 => 124
	i64 8400357532724379117, ; 132: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 70
	i64 8410671156615598628, ; 133: System.Reflection.Emit.Lightweight.dll => 0x74b8b4daf4b25224 => 116
	i64 8563666267364444763, ; 134: System.Private.Uri => 0x76d841191140ca5b => 112
	i64 8614108721271900878, ; 135: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x778b763e14018ace => 21
	i64 8626175481042262068, ; 136: Java.Interop => 0x77b654e585b55834 => 137
	i64 8638972117149407195, ; 137: Microsoft.CSharp.dll => 0x77e3cb5e8b31d7db => 81
	i64 8639588376636138208, ; 138: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 69
	i64 8677882282824630478, ; 139: pt-BR\Microsoft.Maui.Controls.resources => 0x786e07f5766b00ce => 21
	i64 8725526185868997716, ; 140: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 50
	i64 8941376889969657626, ; 141: System.Xml.XDocument => 0x7c1626e87187471a => 133
	i64 9045785047181495996, ; 142: zh-HK\Microsoft.Maui.Controls.resources => 0x7d891592e3cb0ebc => 31
	i64 9312692141327339315, ; 143: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 76
	i64 9324707631942237306, ; 144: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 52
	i64 9659729154652888475, ; 145: System.Text.RegularExpressions => 0x860e407c9991dd9b => 127
	i64 9678050649315576968, ; 146: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 56
	i64 9702891218465930390, ; 147: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 83
	i64 9808709177481450983, ; 148: Mono.Android.dll => 0x881f890734e555e7 => 139
	i64 9956195530459977388, ; 149: Microsoft.Maui => 0x8a2b8315b36616ac => 46
	i64 9991543690424095600, ; 150: es/Microsoft.Maui.Controls.resources.dll => 0x8aa9180c89861370 => 6
	i64 10038780035334861115, ; 151: System.Net.Http.dll => 0x8b50e941206af13b => 100
	i64 10051358222726253779, ; 152: System.Private.Xml => 0x8b7d990c97ccccd3 => 114
	i64 10092835686693276772, ; 153: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 44
	i64 10143853363526200146, ; 154: da\Microsoft.Maui.Controls.resources => 0x8cc634e3c2a16b52 => 3
	i64 10229024438826829339, ; 155: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 59
	i64 10236703004850800690, ; 156: System.Net.ServicePoint.dll => 0x8e101325834e4832 => 106
	i64 10245369515835430794, ; 157: System.Reflection.Emit.Lightweight => 0x8e2edd4ad7fc978a => 116
	i64 10364469296367737616, ; 158: System.Reflection.Emit.ILGeneration.dll => 0x8fd5fde967711b10 => 115
	i64 10406448008575299332, ; 159: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 79
	i64 10430153318873392755, ; 160: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 57
	i64 10506226065143327199, ; 161: ca\Microsoft.Maui.Controls.resources => 0x91cd9cf11ed169df => 1
	i64 10785150219063592792, ; 162: System.Net.Primitives => 0x95ac8cfb68830758 => 103
	i64 11002576679268595294, ; 163: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 41
	i64 11009005086950030778, ; 164: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 46
	i64 11103970607964515343, ; 165: hu\Microsoft.Maui.Controls.resources => 0x9a193a6fc41a6c0f => 12
	i64 11162124722117608902, ; 166: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 75
	i64 11220793807500858938, ; 167: ja\Microsoft.Maui.Controls.resources => 0x9bb8448481fdd63a => 15
	i64 11226290749488709958, ; 168: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 42
	i64 11340910727871153756, ; 169: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 58
	i64 11485890710487134646, ; 170: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 118
	i64 11518296021396496455, ; 171: id\Microsoft.Maui.Controls.resources => 0x9fd9353475222047 => 13
	i64 11529969570048099689, ; 172: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 75
	i64 11530571088791430846, ; 173: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 40
	i64 11597940890313164233, ; 174: netstandard => 0xa0f429ca8d1805c9 => 135
	i64 11705530742807338875, ; 175: he/Microsoft.Maui.Controls.resources.dll => 0xa272663128721f7b => 9
	i64 12040886584167504988, ; 176: System.Net.ServicePoint => 0xa719d28d8e121c5c => 106
	i64 12145679461940342714, ; 177: System.Text.Json => 0xa88e1f1ebcb62fba => 126
	i64 12201331334810686224, ; 178: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 122
	i64 12451044538927396471, ; 179: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 61
	i64 12466513435562512481, ; 180: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 66
	i64 12475113361194491050, ; 181: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 34
	i64 12517810545449516888, ; 182: System.Diagnostics.TraceSource.dll => 0xadb8325e6f283f58 => 91
	i64 12538491095302438457, ; 183: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 54
	i64 12550732019250633519, ; 184: System.IO.Compression => 0xae2d28465e8e1b2f => 96
	i64 12681088699309157496, ; 185: it/Microsoft.Maui.Controls.resources.dll => 0xaffc46fc178aec78 => 14
	i64 12700543734426720211, ; 186: Xamarin.AndroidX.Collection => 0xb041653c70d157d3 => 55
	i64 12708922737231849740, ; 187: System.Text.Encoding.Extensions => 0xb05f29e50e96e90c => 125
	i64 12823819093633476069, ; 188: th/Microsoft.Maui.Controls.resources.dll => 0xb1f75b85abe525e5 => 27
	i64 12843321153144804894, ; 189: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 43
	i64 12859557719246324186, ; 190: System.Net.WebHeaderCollection.dll => 0xb276539ce04f41da => 108
	i64 13068258254871114833, ; 191: System.Runtime.Serialization.Formatters.dll => 0xb55bc7a4eaa8b451 => 121
	i64 13221551921002590604, ; 192: ca/Microsoft.Maui.Controls.resources.dll => 0xb77c636bdebe318c => 1
	i64 13222659110913276082, ; 193: ja/Microsoft.Maui.Controls.resources.dll => 0xb78052679c1178b2 => 15
	i64 13343850469010654401, ; 194: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 138
	i64 13381594904270902445, ; 195: he\Microsoft.Maui.Controls.resources => 0xb9b4f9aaad3e94ad => 9
	i64 13465488254036897740, ; 196: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 78
	i64 13467053111158216594, ; 197: uk/Microsoft.Maui.Controls.resources.dll => 0xbae49573fde79792 => 29
	i64 13540124433173649601, ; 198: vi\Microsoft.Maui.Controls.resources => 0xbbe82f6eede718c1 => 30
	i64 13545416393490209236, ; 199: id/Microsoft.Maui.Controls.resources.dll => 0xbbfafc7174bc99d4 => 13
	i64 13572454107664307259, ; 200: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 71
	i64 13608364852675295459, ; 201: PriceTrackerApp => 0xbcda9fbbb99f38e3 => 80
	i64 13717397318615465333, ; 202: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 86
	i64 13755568601956062840, ; 203: fr/Microsoft.Maui.Controls.resources.dll => 0xbee598c36b1b9678 => 8
	i64 13814445057219246765, ; 204: hr/Microsoft.Maui.Controls.resources.dll => 0xbfb6c49664b43aad => 11
	i64 13881769479078963060, ; 205: System.Console.dll => 0xc0a5f3cade5c6774 => 89
	i64 13959074834287824816, ; 206: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 61
	i64 14100563506285742564, ; 207: da/Microsoft.Maui.Controls.resources.dll => 0xc3af43cd0cff89e4 => 3
	i64 14124974489674258913, ; 208: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 54
	i64 14125464355221830302, ; 209: System.Threading.dll => 0xc407bafdbc707a9e => 130
	i64 14254574811015963973, ; 210: System.Text.Encoding.Extensions.dll => 0xc5d26c4442d66545 => 125
	i64 14461014870687870182, ; 211: System.Net.Requests.dll => 0xc8afd8683afdece6 => 104
	i64 14464374589798375073, ; 212: ru\Microsoft.Maui.Controls.resources => 0xc8bbc80dcb1e5ea1 => 24
	i64 14501706728687516346, ; 213: PriceTrackerApp.dll => 0xc940696fb84fbaba => 80
	i64 14522721392235705434, ; 214: el/Microsoft.Maui.Controls.resources.dll => 0xc98b12295c2cf45a => 5
	i64 14622043554576106986, ; 215: System.Runtime.Serialization.Formatters => 0xcaebef2458cc85ea => 121
	i64 14669215534098758659, ; 216: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 38
	i64 14705122255218365489, ; 217: ko\Microsoft.Maui.Controls.resources => 0xcc1316c7b0fb5431 => 16
	i64 14744092281598614090, ; 218: zh-Hans\Microsoft.Maui.Controls.resources => 0xcc9d89d004439a4a => 32
	i64 14852515768018889994, ; 219: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 58
	i64 14892012299694389861, ; 220: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xceab0e490a083a65 => 33
	i64 14904040806490515477, ; 221: ar\Microsoft.Maui.Controls.resources => 0xced5ca2604cb2815 => 0
	i64 14954917835170835695, ; 222: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 39
	i64 14984936317414011727, ; 223: System.Net.WebHeaderCollection => 0xcff5302fe54ff34f => 108
	i64 14987728460634540364, ; 224: System.IO.Compression.dll => 0xcfff1ba06622494c => 96
	i64 15015154896917945444, ; 225: System.Net.Security.dll => 0xd0608bd33642dc64 => 105
	i64 15076659072870671916, ; 226: System.ObjectModel.dll => 0xd13b0d8c1620662c => 111
	i64 15111608613780139878, ; 227: ms\Microsoft.Maui.Controls.resources => 0xd1b737f831192f66 => 17
	i64 15115185479366240210, ; 228: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 95
	i64 15133485256822086103, ; 229: System.Linq.dll => 0xd204f0a9127dd9d7 => 98
	i64 15227001540531775957, ; 230: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 37
	i64 15370334346939861994, ; 231: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 57
	i64 15391712275433856905, ; 232: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 39
	i64 15527772828719725935, ; 233: System.Console => 0xd77dbb1e38cd3d6f => 89
	i64 15536481058354060254, ; 234: de\Microsoft.Maui.Controls.resources => 0xd79cab34eec75bde => 4
	i64 15557562860424774966, ; 235: System.Net.Sockets => 0xd7e790fe7a6dc536 => 107
	i64 15582737692548360875, ; 236: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 65
	i64 15609085926864131306, ; 237: System.dll => 0xd89e9cf3334914ea => 134
	i64 15661133872274321916, ; 238: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 132
	i64 15664356999916475676, ; 239: de/Microsoft.Maui.Controls.resources.dll => 0xd962f9b2b6ecd51c => 4
	i64 15743187114543869802, ; 240: hu/Microsoft.Maui.Controls.resources.dll => 0xda7b09450ae4ef6a => 12
	i64 15783653065526199428, ; 241: el\Microsoft.Maui.Controls.resources => 0xdb0accd674b1c484 => 5
	i64 15847085070278954535, ; 242: System.Threading.Channels.dll => 0xdbec27e8f35f8e27 => 128
	i64 16018552496348375205, ; 243: System.Net.NetworkInformation.dll => 0xde4d54a020caa8a5 => 102
	i64 16154507427712707110, ; 244: System => 0xe03056ea4e39aa26 => 134
	i64 16219561732052121626, ; 245: System.Net.Security => 0xe1177575db7c781a => 105
	i64 16288847719894691167, ; 246: nb\Microsoft.Maui.Controls.resources => 0xe20d9cb300c12d5f => 18
	i64 16321164108206115771, ; 247: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 41
	i64 16454459195343277943, ; 248: System.Net.NetworkInformation => 0xe459fb756d988f77 => 102
	i64 16649148416072044166, ; 249: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 48
	i64 16677317093839702854, ; 250: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 70
	i64 16856067890322379635, ; 251: System.Data.Common.dll => 0xe9ecc87060889373 => 90
	i64 16890310621557459193, ; 252: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 127
	i64 16933958494752847024, ; 253: System.Net.WebProxy.dll => 0xeb018187f0f3b4b0 => 109
	i64 16942731696432749159, ; 254: sk\Microsoft.Maui.Controls.resources => 0xeb20acb622a01a67 => 25
	i64 16998075588627545693, ; 255: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 68
	i64 17008137082415910100, ; 256: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 83
	i64 17031351772568316411, ; 257: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 67
	i64 17062143951396181894, ; 258: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 86
	i64 17089008752050867324, ; 259: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xed285aeb25888c7c => 32
	i64 17118171214553292978, ; 260: System.Threading.Channels => 0xed8ff6060fc420b2 => 128
	i64 17230721278011714856, ; 261: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 113
	i64 17260702271250283638, ; 262: System.Data.Common => 0xef8a5543bba6bc76 => 90
	i64 17342750010158924305, ; 263: hi\Microsoft.Maui.Controls.resources => 0xf0add33f97ecc211 => 10
	i64 17438153253682247751, ; 264: sk/Microsoft.Maui.Controls.resources.dll => 0xf200c3fe308d7847 => 25
	i64 17514990004910432069, ; 265: fr\Microsoft.Maui.Controls.resources => 0xf311be9c6f341f45 => 8
	i64 17623389608345532001, ; 266: pl\Microsoft.Maui.Controls.resources => 0xf492db79dfbef661 => 20
	i64 17702523067201099846, ; 267: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xf5abfef008ae1846 => 31
	i64 17704177640604968747, ; 268: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 66
	i64 17710060891934109755, ; 269: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 64
	i64 17712670374920797664, ; 270: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 118
	i64 17777860260071588075, ; 271: System.Runtime.Numerics.dll => 0xf6b7a5b72419c0eb => 120
	i64 18025913125965088385, ; 272: System.Threading => 0xfa28e87b91334681 => 130
	i64 18099568558057551825, ; 273: nl/Microsoft.Maui.Controls.resources.dll => 0xfb2e95b53ad977d1 => 19
	i64 18121036031235206392, ; 274: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 67
	i64 18146411883821974900, ; 275: System.Formats.Asn1.dll => 0xfbd50176eb22c574 => 94
	i64 18245806341561545090, ; 276: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 82
	i64 18305135509493619199, ; 277: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 69
	i64 18324163916253801303, ; 278: it\Microsoft.Maui.Controls.resources => 0xfe4c81ff0a56ab57 => 14
	i64 18380184030268848184 ; 279: Xamarin.AndroidX.VersionedParcelable => 0xff1387fe3e7b7838 => 74
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [280 x i32] [
	i32 43, ; 0
	i32 139, ; 1
	i32 47, ; 2
	i32 97, ; 3
	i32 55, ; 4
	i32 72, ; 5
	i32 7, ; 6
	i32 117, ; 7
	i32 129, ; 8
	i32 88, ; 9
	i32 10, ; 10
	i32 60, ; 11
	i32 35, ; 12
	i32 117, ; 13
	i32 77, ; 14
	i32 18, ; 15
	i32 93, ; 16
	i32 68, ; 17
	i32 103, ; 18
	i32 44, ; 19
	i32 138, ; 20
	i32 129, ; 21
	i32 16, ; 22
	i32 53, ; 23
	i32 65, ; 24
	i32 49, ; 25
	i32 99, ; 26
	i32 112, ; 27
	i32 52, ; 28
	i32 6, ; 29
	i32 72, ; 30
	i32 92, ; 31
	i32 28, ; 32
	i32 45, ; 33
	i32 28, ; 34
	i32 64, ; 35
	i32 2, ; 36
	i32 20, ; 37
	i32 92, ; 38
	i32 49, ; 39
	i32 60, ; 40
	i32 82, ; 41
	i32 24, ; 42
	i32 63, ; 43
	i32 56, ; 44
	i32 123, ; 45
	i32 51, ; 46
	i32 27, ; 47
	i32 101, ; 48
	i32 38, ; 49
	i32 2, ; 50
	i32 7, ; 51
	i32 109, ; 52
	i32 77, ; 53
	i32 62, ; 54
	i32 110, ; 55
	i32 120, ; 56
	i32 107, ; 57
	i32 79, ; 58
	i32 35, ; 59
	i32 47, ; 60
	i32 36, ; 61
	i32 73, ; 62
	i32 136, ; 63
	i32 22, ; 64
	i32 123, ; 65
	i32 37, ; 66
	i32 132, ; 67
	i32 36, ; 68
	i32 135, ; 69
	i32 71, ; 70
	i32 40, ; 71
	i32 45, ; 72
	i32 104, ; 73
	i32 99, ; 74
	i32 122, ; 75
	i32 114, ; 76
	i32 33, ; 77
	i32 88, ; 78
	i32 97, ; 79
	i32 87, ; 80
	i32 30, ; 81
	i32 74, ; 82
	i32 0, ; 83
	i32 51, ; 84
	i32 73, ; 85
	i32 93, ; 86
	i32 101, ; 87
	i32 119, ; 88
	i32 84, ; 89
	i32 84, ; 90
	i32 119, ; 91
	i32 26, ; 92
	i32 29, ; 93
	i32 95, ; 94
	i32 124, ; 95
	i32 76, ; 96
	i32 94, ; 97
	i32 23, ; 98
	i32 23, ; 99
	i32 126, ; 100
	i32 115, ; 101
	i32 34, ; 102
	i32 63, ; 103
	i32 11, ; 104
	i32 59, ; 105
	i32 42, ; 106
	i32 19, ; 107
	i32 22, ; 108
	i32 91, ; 109
	i32 133, ; 110
	i32 131, ; 111
	i32 110, ; 112
	i32 113, ; 113
	i32 26, ; 114
	i32 98, ; 115
	i32 87, ; 116
	i32 131, ; 117
	i32 111, ; 118
	i32 100, ; 119
	i32 17, ; 120
	i32 136, ; 121
	i32 81, ; 122
	i32 78, ; 123
	i32 53, ; 124
	i32 85, ; 125
	i32 62, ; 126
	i32 50, ; 127
	i32 137, ; 128
	i32 85, ; 129
	i32 48, ; 130
	i32 124, ; 131
	i32 70, ; 132
	i32 116, ; 133
	i32 112, ; 134
	i32 21, ; 135
	i32 137, ; 136
	i32 81, ; 137
	i32 69, ; 138
	i32 21, ; 139
	i32 50, ; 140
	i32 133, ; 141
	i32 31, ; 142
	i32 76, ; 143
	i32 52, ; 144
	i32 127, ; 145
	i32 56, ; 146
	i32 83, ; 147
	i32 139, ; 148
	i32 46, ; 149
	i32 6, ; 150
	i32 100, ; 151
	i32 114, ; 152
	i32 44, ; 153
	i32 3, ; 154
	i32 59, ; 155
	i32 106, ; 156
	i32 116, ; 157
	i32 115, ; 158
	i32 79, ; 159
	i32 57, ; 160
	i32 1, ; 161
	i32 103, ; 162
	i32 41, ; 163
	i32 46, ; 164
	i32 12, ; 165
	i32 75, ; 166
	i32 15, ; 167
	i32 42, ; 168
	i32 58, ; 169
	i32 118, ; 170
	i32 13, ; 171
	i32 75, ; 172
	i32 40, ; 173
	i32 135, ; 174
	i32 9, ; 175
	i32 106, ; 176
	i32 126, ; 177
	i32 122, ; 178
	i32 61, ; 179
	i32 66, ; 180
	i32 34, ; 181
	i32 91, ; 182
	i32 54, ; 183
	i32 96, ; 184
	i32 14, ; 185
	i32 55, ; 186
	i32 125, ; 187
	i32 27, ; 188
	i32 43, ; 189
	i32 108, ; 190
	i32 121, ; 191
	i32 1, ; 192
	i32 15, ; 193
	i32 138, ; 194
	i32 9, ; 195
	i32 78, ; 196
	i32 29, ; 197
	i32 30, ; 198
	i32 13, ; 199
	i32 71, ; 200
	i32 80, ; 201
	i32 86, ; 202
	i32 8, ; 203
	i32 11, ; 204
	i32 89, ; 205
	i32 61, ; 206
	i32 3, ; 207
	i32 54, ; 208
	i32 130, ; 209
	i32 125, ; 210
	i32 104, ; 211
	i32 24, ; 212
	i32 80, ; 213
	i32 5, ; 214
	i32 121, ; 215
	i32 38, ; 216
	i32 16, ; 217
	i32 32, ; 218
	i32 58, ; 219
	i32 33, ; 220
	i32 0, ; 221
	i32 39, ; 222
	i32 108, ; 223
	i32 96, ; 224
	i32 105, ; 225
	i32 111, ; 226
	i32 17, ; 227
	i32 95, ; 228
	i32 98, ; 229
	i32 37, ; 230
	i32 57, ; 231
	i32 39, ; 232
	i32 89, ; 233
	i32 4, ; 234
	i32 107, ; 235
	i32 65, ; 236
	i32 134, ; 237
	i32 132, ; 238
	i32 4, ; 239
	i32 12, ; 240
	i32 5, ; 241
	i32 128, ; 242
	i32 102, ; 243
	i32 134, ; 244
	i32 105, ; 245
	i32 18, ; 246
	i32 41, ; 247
	i32 102, ; 248
	i32 48, ; 249
	i32 70, ; 250
	i32 90, ; 251
	i32 127, ; 252
	i32 109, ; 253
	i32 25, ; 254
	i32 68, ; 255
	i32 83, ; 256
	i32 67, ; 257
	i32 86, ; 258
	i32 32, ; 259
	i32 128, ; 260
	i32 113, ; 261
	i32 90, ; 262
	i32 10, ; 263
	i32 25, ; 264
	i32 8, ; 265
	i32 20, ; 266
	i32 31, ; 267
	i32 66, ; 268
	i32 64, ; 269
	i32 118, ; 270
	i32 120, ; 271
	i32 130, ; 272
	i32 19, ; 273
	i32 67, ; 274
	i32 94, ; 275
	i32 82, ; 276
	i32 69, ; 277
	i32 14, ; 278
	i32 74 ; 279
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

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
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
