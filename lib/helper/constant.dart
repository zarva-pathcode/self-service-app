import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

 //? LOCAL HTTP
//http://192.168.100.13?
const localBaseURL = "http://192.168.100.13/wssteak_selfservice";

const localEndpoint = "$localBaseURL/api";
const localMenuImageURL = "$localBaseURL/images/menu";
const alatBayarImageLocalURL = "$localBaseURL/images/alat_bayar";
const subAlatBayarImageLocalURL = "$localBaseURL/images/sub_alat_bayar";

//? NETWORK HTTP

const remoteURL = "https://www.zarvaism.cloud/wssteak_selfservice";

const remoteEndpoint = "$remoteURL/api";    
const remoteMenuImageURL = "$remoteURL/images/menu";
const remoteAlatBayarImageURL = "$remoteURL/images/alat_bayar";
const remoteSubAlatBayarImageURL =
    "$remoteEndpoint/images/sub_alat_bayar";

enum PaymentState { empty, tunai, nonTunai, onHoverTunai, onHoverNonTunai }

final currency = NumberFormat('#,##0', "en_US");
final DateFormat displayDate = DateFormat("EEEE, MMMM d, yyyy", "id_ID");
GlobalKey<AnimatedListState> keyList = GlobalKey<AnimatedListState>();

TextStyle regularText =
    const TextStyle(fontFamily: "OpenSans", color: Colors.black);

Color primaryColor = Colors.green[700]!;
Color accentColor = Colors.green[400]!;

 final cacheManager = CacheManager(Config(
    'cacheKey',
    stalePeriod: const Duration(days: 1),
    maxNrOfCacheObjects: 50,
  ));
