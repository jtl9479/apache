# Apache Tomcat 7.0.78 PDA 프로젝트 분석 문서

## 1. 프로젝트 개요

- **프로젝트명**: PDA (Personal Digital Assistant) 물류 관리 시스템
- **서버**: Apache Tomcat 7.0.78
- **데이터베이스**: Oracle Database
- **기술 스택**: Java EE 3.0, JSP, JDBC, Log4j
- **목적**: 소매점(홈플러스, 롯데, 오노마켓 등) 물류/배송/재고 관리

---

## 2. 전체 프로젝트 디렉토리 구조

```
apache-tomcat-7.0.78_PDA_IN/
├── bin/                           # 실행 파일 및 스크립트
│   ├── catalina.bat, startup.bat  # Windows 실행 스크립트
│   ├── bootstrap.jar              # Tomcat 부트스트랩
│   └── 기타 유틸리티
│
├── conf/                          # 서버 설정 파일
│   ├── server.xml                 # Tomcat 서버 설정 (포트: 4040)
│   ├── web.xml                    # 기본 웹앱 설정
│   ├── tomcat-users.xml           # 사용자 인증
│   └── logging.properties         # 로깅 설정
│
├── lib/                           # 공통 라이브러리 (18개+)
│   ├── catalina.jar               # Tomcat 핵심
│   ├── jasper.jar                 # JSP 컴파일러
│   ├── ojdbc6.jar                 # Oracle JDBC 드라이버
│   ├── log4j-1.2.17.jar           # 로깅 라이브러리
│   ├── servlet-api.jar            # Servlet 스펙
│   └── jsp-api.jar                # JSP 스펙
│
├── logs/                          # 로그 파일 저장
├── temp/                          # 임시 파일
├── work/                          # JSP 컴파일 결과
│   └── Catalina/localhost/_/org/apache/jsp/inno/
│
├── webapps/                       # 웹 애플리케이션
│   ├── ROOT/                      # 메인 PDA 애플리케이션
│   │   ├── inno/                  # 비즈니스 로직 JSP 파일들
│   │   └── WEB-INF/
│   │       └── web.xml            # UTF-8 인코딩 필터 설정
│   ├── manager/                   # Tomcat 관리 앱
│   └── host-manager/              # 호스트 관리 앱
│
└── RUNNING.txt                    # 실행 가이드
```

---

## 3. webapps/ROOT/inno 디렉토리 - 주요 컴포넌트

### 3.1 JSP 파일 패턴 분석 (총 25개)

#### INSERT 패턴 (4개) - 데이터 입력
| 파일명 | 크기 | 용도 |
|--------|------|------|
| [insert_goods_wet.jsp](webapps/ROOT/inno/insert_goods_wet.jsp) | 5,127 bytes | 상품 무게 정보 입력 (일반) |
| [insert_goods_wet_homeplus.jsp](webapps/ROOT/inno/insert_goods_wet_homeplus.jsp) | 5,267 bytes | 상품 무게 정보 입력 (홈플러스) |
| [insert_goods_wet_new.jsp](webapps/ROOT/inno/insert_goods_wet_new.jsp) | 4,167 bytes | 상품 무게 정보 입력 (신규) |
| [insert_goods_wet_ono.jsp](webapps/ROOT/inno/insert_goods_wet_ono.jsp) | 3,067 bytes | 상품 무게 정보 입력 (오노마켓) |

#### SEARCH 패턴 (17개) - 데이터 조회

**바코드 정보 검색 (4개)**
- [search_barcode_info.jsp](webapps/ROOT/inno/search_barcode_info.jsp) - 바코드 정보 조회
- [search_barcode_info_nonfixed.jsp](webapps/ROOT/inno/search_barcode_info_nonfixed.jsp) - 비고정 바코드 조회
- [search_barcode_info_temp.jsp](webapps/ROOT/inno/search_barcode_info_temp.jsp) - 임시 바코드 조회
- [search_barcode_info_temp_diff_prd.jsp](webapps/ROOT/inno/search_barcode_info_temp_diff_prd.jsp) - 상품별 임시 바코드

**상품/생산 정보 검색 (5개)**
- [search_goods_wet.jsp](webapps/ROOT/inno/search_goods_wet.jsp) - 상품 무게 정보 검색
- [search_production.jsp](webapps/ROOT/inno/search_production.jsp) - 생산 정보 조회
- [search_production_4label.jsp](webapps/ROOT/inno/search_production_4label.jsp) - 4라벨 생산 정보
- [search_production_calc.jsp](webapps/ROOT/inno/search_production_calc.jsp) - 생산 계산
- [search_production_nonfixed.jsp](webapps/ROOT/inno/search_production_nonfixed.jsp) - 비고정 생산 정보

**홈플러스 관련 (2개)**
- [search_homeplus_nonfixed.jsp](webapps/ROOT/inno/search_homeplus_nonfixed.jsp) - 홈플러스 비고정 조회
- [search_homeplus_nonfixed2.jsp](webapps/ROOT/inno/search_homeplus_nonfixed2.jsp) - 홈플러스 비고정 조회 v2

**배송 정보 검색 (7개)**
- [search_shipment.jsp](webapps/ROOT/inno/search_shipment.jsp) - 일반 배송 조회
- [search_shipment_homeplus.jsp](webapps/ROOT/inno/search_shipment_homeplus.jsp) - 홈플러스 배송
- [search_shipment_lotte.jsp](webapps/ROOT/inno/search_shipment_lotte.jsp) - 롯데마트 배송
- [search_shipment_ono.jsp](webapps/ROOT/inno/search_shipment_ono.jsp) - 오노마켓 배송
- [search_shipment_ono_temp.jsp](webapps/ROOT/inno/search_shipment_ono_temp.jsp) - 오노마켓 임시 배송
- [search_shipment_ono_temp_diff_prd.jsp](webapps/ROOT/inno/search_shipment_ono_temp_diff_prd.jsp) - 오노마켓 상품별 임시 배송
- [search_shipment_wholesale.jsp](webapps/ROOT/inno/search_shipment_wholesale.jsp) - 도매 배송

#### UPDATE 패턴 (1개) - 데이터 수정
- [update_shipment.jsp](webapps/ROOT/inno/update_shipment.jsp) (4,959 bytes) - 배송 정보 수정

#### 기타 (3개)
- [manager_login.jsp](webapps/ROOT/inno/manager_login.jsp) (1,816 bytes) - 관리자 로그인
- [test.jsp](webapps/ROOT/inno/test.jsp) (5,046 bytes) - 테스트 페이지

---

## 4. 특정 기능 분석: insert_goods_wet_homeplus.jsp

### 4.1 파일 정보
- **경로**: [webapps/ROOT/inno/insert_goods_wet_homeplus.jsp](webapps/ROOT/inno/insert_goods_wet_homeplus.jsp)
- **크기**: 5,267 bytes
- **역할**: 홈플러스 매장 상품 무게 정보를 W_GOODS_WET 테이블에 입력

### 4.2 기능 흐름도

```
[PDA 디바이스]
     ↓
[HTTP Request - data 파라미터]
     ↓
[JSP: insert_goods_wet_homeplus.jsp]
     ↓
[Oracle DB 연결]
     ↓
[데이터 파싱 (:: 구분자)]
     ↓
[W_GOODS_WET 테이블 INSERT]
     ↓
[Commit & Response]
     ↓
["s" (성공) or "f" (실패)]
```

### 4.3 주요 코드 분석

#### 4.3.1 데이터베이스 연결
```jsp
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@1.1.1.1:SIDname";
Connection conn = DriverManager.getConnection(url, dbid, "DBpassword");
```
- Oracle JDBC Thin Driver 사용
- 연결 정보: IP 1.1.1.1, SID: SIDname
- 동적 사용자 인증 (dbid 파라미터)

#### 4.3.2 입력 파라미터 파싱
```jsp
String data = request.getParameter("data");
String dbid = request.getParameter("dbid");
String[] splitData = data.split("::");
```

**splitData 배열 구조** (14개 필드):
| Index | 필드명 | 데이터 타입 | 설명 |
|-------|--------|-------------|------|
| 0 | GI_D_ID | Integer | 상품 입고 상세 ID |
| 1 | WEIGHT | Double | 무게 (소수점 2자리) |
| 2 | WEIGHT_UNIT | String | 무게 단위 (kg, g 등) |
| 3 | PACKER_PRODUCT_CODE | String | 포장업체 상품 코드 |
| 4 | BARCODE | String | 바코드 번호 |
| 5 | PACKER_CLIENT_CODE | String | 포장업체 거래처 코드 |
| 6 | MAKINGDATE | String | 제조일자 |
| 7 | BOXSERIAL | String | 박스 시리얼 번호 |
| 8 | BOX_CNT | Integer | 박스 수량 |
| 9 | REG_ID | String | 등록자 ID |
| 10 | (사용 안함) | - | 예비 필드 |
| 11 | (사용 안함) | - | 예비 필드 |
| 12 | CHANNEL_CODE | String | 채널 코드 (홈플러스 등) |
| 13 | BOX_ORDER | Integer | 박스 순서 |

#### 4.3.3 INSERT 쿼리 실행
```sql
INSERT INTO W_GOODS_WET(
    GOODS_WET_ID,        -- 시퀀스 자동 생성
    GI_D_ID,
    WEIGHT,
    WEIGHT_UNIT,
    PACKER_PRODUCT_CODE,
    BARCODE,
    PACKER_CLIENT_CODE,
    MAKINGDATE,
    BOXSERIAL,
    BOX_CNT,
    REG_ID,
    REG_DATE,            -- yyyyMMdd
    REG_TIME,            -- HHmmss
    CHANNEL_CODE,
    BOX_ORDER
) VALUES (W_GOODS_WET_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
```

**특징**:
- `W_GOODS_WET_SEQ.NEXTVAL`로 PK 자동 생성
- `PreparedStatement` 사용 (SQL Injection 방지)
- 무게는 소수점 2자리까지 반올림: `(Double.parseDouble(splitData[1]) * 100) / 100.0`
- 등록일시는 서버 시간 기준 자동 생성

#### 4.3.4 로깅
```jsp
Logger logger = Logger.getLogger("insert_goods_wet.jsp");
logger.info("##insert_goods_wet all parameter :" + data);
logger.info("========GI_D_ID===================" + splitData[0]);
logger.info("========WEIGHT====================" + splitData[1]);
```
- Log4j 프레임워크 사용
- 모든 입력 파라미터와 주요 필드 기록
- 트랜잭션 시작/종료 로깅

#### 4.3.5 응답 처리
```jsp
try {
    // 쿼리 실행
    pstmt.executeUpdate();
    conn.commit();
    out.println("s");  // 성공
} catch (Exception ex) {
    out.println("f");  // 실패
    out.println(ex.getMessage());
    conn.rollback();
}
```
- 성공: `"s"` 문자열 반환
- 실패: `"f"` + 에러 메시지 반환
- 명시적 트랜잭션 관리 (commit/rollback)

### 4.4 데이터 흐름 예시

**요청 예시**:
```
POST /inno/insert_goods_wet_homeplus.jsp
data=1234567::12.30::KG::P001::8801234567890::C001::20250127::BOX001::5::USER01::::HP::1
dbid=pda_user
```

**데이터 파싱 결과**:
- GI_D_ID: 1234567
- WEIGHT: 12.30 kg
- BARCODE: 8801234567890
- BOX_CNT: 5개
- CHANNEL_CODE: HP (홈플러스)
- REG_DATE: 20250127 (자동 생성)
- REG_TIME: 153045 (자동 생성)

**응답**: `s` (성공)

### 4.5 주석 처리된 기능

파일 내 103-121라인에 주석 처리된 UPDATE 쿼리가 있음:
```sql
-- W_GOODS_ID 테이블 업데이트 (사용 안함)
UPDATE W_GOODS_ID SET
    GI_QTY = GI_QTY + ?,           -- 수량 누적
    PACKING_QTY = PACKING_QTY + 1, -- 포장 수량 증가
    ...
WHERE GI_D_ID = ? AND ITEM_CODE = ? AND BRAND_CODE = ?
```
- 원래는 INSERT 후 집계 테이블 UPDATE 수행
- 현재는 비활성화 (별도 배치 처리 추정)

---

## 5. 서버 설정

### 5.1 Tomcat 서버 설정 (conf/server.xml)
```xml
<Connector port="4040"
           protocol="HTTP/1.1"
           URIEncoding="UTF-8"
           connectionTimeout="20000"
           redirectPort="58444" />

<Connector port="58010"
           protocol="AJP/1.3"
           redirectPort="58444" />
```
- **HTTP 포트**: 4040
- **AJP 포트**: 58010 (로드밸런서 연동용)
- **Shutdown 포트**: 58006
- **UTF-8 인코딩**: 모든 요청에 적용

### 5.2 웹 애플리케이션 설정 (webapps/ROOT/WEB-INF/web.xml)
```xml
<filter>
    <filter-name>CharacterEncodingFilter</filter-name>
    <filter-class>org.apache.catalina.filters.SetCharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
</filter>

<filter-mapping>
    <filter-name>CharacterEncodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```
- 모든 요청/응답에 UTF-8 인코딩 필터 적용
- 한글 데이터 처리를 위한 필수 설정

---

## 6. 데이터베이스 구조 추정

### 6.1 W_GOODS_WET 테이블 (상품 무게 정보)
```sql
CREATE TABLE W_GOODS_WET (
    GOODS_WET_ID       NUMBER PRIMARY KEY,     -- 시퀀스
    GI_D_ID            NUMBER NOT NULL,        -- 입고 상세 ID (FK)
    WEIGHT             NUMBER(10,2),           -- 무게
    WEIGHT_UNIT        VARCHAR2(10),           -- 단위
    PACKER_PRODUCT_CODE VARCHAR2(50),          -- 포장업체 상품코드
    BARCODE            VARCHAR2(50),           -- 바코드
    PACKER_CLIENT_CODE VARCHAR2(50),           -- 포장업체 거래처코드
    MAKINGDATE         VARCHAR2(8),            -- 제조일자
    BOXSERIAL          VARCHAR2(50),           -- 박스시리얼
    BOX_CNT            NUMBER,                 -- 박스수량
    REG_ID             VARCHAR2(20),           -- 등록자
    REG_DATE           VARCHAR2(8),            -- 등록일자
    REG_TIME           VARCHAR2(6),            -- 등록시간
    CHANNEL_CODE       VARCHAR2(10),           -- 채널코드
    BOX_ORDER          NUMBER                  -- 박스순서
);

CREATE SEQUENCE W_GOODS_WET_SEQ;
```

### 6.2 관련 테이블 추정
- **W_GOODS_ID**: 상품 입고 마스터 테이블
- **W_SHIPMENT**: 배송 정보 테이블
- **W_PRODUCTION**: 생산 정보 테이블
- **W_BARCODE**: 바코드 마스터 테이블

---

## 7. 기술 스택 및 특징

### 7.1 사용 기술
| 항목 | 기술 | 버전/설명 |
|------|------|-----------|
| **WAS** | Apache Tomcat | 7.0.78 (2017년) |
| **언어** | Java | JSP 기반 |
| **DB** | Oracle Database | JDBC Thin Driver |
| **로깅** | Log4j | 1.2.17 |
| **표준** | Java EE | Servlet 3.0 스펙 |

### 7.2 주요 특징
1. **다중 소매점 지원**: 홈플러스, 롯데, 오노마켓 등 개별 JSP 파일
2. **PDA 기반**: 모바일 단말기에서 데이터 입력
3. **실시간 트랜잭션**: 상품 무게 측정 즉시 DB 저장
4. **바코드 기반 관리**: 바코드 스캔으로 상품 식별
5. **레거시 아키텍처**: JSP에 비즈니스 로직 직접 포함 (MVC 패턴 미적용)

### 7.3 보안 고려사항
- DB 접속 정보 하드코딩 (코드 내 평문 저장)
- 동적 사용자 인증 (dbid 파라미터)
- PreparedStatement 사용으로 SQL Injection 방지
- HTTPS 미사용 (HTTP 4040 포트)

---

## 8. 개선 제안 사항

### 8.1 보안
- [ ] DB 접속 정보 외부 설정 파일로 분리 (JNDI DataSource 사용)
- [ ] HTTPS 적용 (SSL/TLS)
- [ ] 비밀번호 암호화

### 8.2 아키텍처
- [ ] MVC 패턴 적용 (Servlet + JSP 분리)
- [ ] Connection Pool 사용 (현재 매 요청마다 새 연결)
- [ ] DAO/Service 계층 분리

### 8.3 유지보수성
- [ ] 공통 코드 모듈화 (DB 연결, 로깅 등)
- [ ] 설정 파일 외부화 (properties/XML)
- [ ] 에러 처리 표준화

### 8.4 모니터링
- [ ] 접근 로그 분석
- [ ] 성능 모니터링 (쿼리 실행 시간)
- [ ] 예외 발생 알림

---

## 9. 파일 참조

### 9.1 주요 설정 파일
- [conf/server.xml](conf/server.xml) - Tomcat 서버 설정
- [webapps/ROOT/WEB-INF/web.xml](webapps/ROOT/WEB-INF/web.xml) - 웹앱 설정
- [RUNNING.txt](RUNNING.txt) - 서버 실행 가이드

### 9.2 비즈니스 로직 파일 (inno 디렉토리)
**홈플러스 관련**:
- [insert_goods_wet_homeplus.jsp](webapps/ROOT/inno/insert_goods_wet_homeplus.jsp:1-154) - 상품 무게 입력
- [search_shipment_homeplus.jsp](webapps/ROOT/inno/search_shipment_homeplus.jsp) - 배송 조회
- [search_homeplus_nonfixed.jsp](webapps/ROOT/inno/search_homeplus_nonfixed.jsp) - 비고정 조회

**롯데마트 관련**:
- [search_shipment_lotte.jsp](webapps/ROOT/inno/search_shipment_lotte.jsp) - 배송 조회

**오노마켓 관련**:
- [insert_goods_wet_ono.jsp](webapps/ROOT/inno/insert_goods_wet_ono.jsp) - 상품 무게 입력
- [search_shipment_ono.jsp](webapps/ROOT/inno/search_shipment_ono.jsp) - 배송 조회

### 9.3 라이브러리
- [lib/ojdbc6.jar](lib/ojdbc6.jar) - Oracle JDBC 드라이버
- [lib/log4j-1.2.17.jar](lib/log4j-1.2.17.jar) - 로깅 라이브러리

---

## 10. 요약

이 프로젝트는 **소매점 물류 관리를 위한 레거시 JSP 기반 PDA 시스템**입니다.

**핵심 기능**:
- 상품 무게 정보 실시간 입력 (바코드 스캔)
- 배송/생산/바코드 정보 조회
- 다중 채널 지원 (홈플러스, 롯데, 오노마켓 등)

**기술적 특징**:
- Oracle DB 직접 연결 방식
- JSP에 비즈니스 로직 포함
- 단순한 요청-응답 구조
- Log4j 기반 트랜잭션 로깅

**개선 필요 영역**:
- 보안 강화 (HTTPS, 접속 정보 암호화)
- 아키텍처 현대화 (MVC, Connection Pool)
- 코드 모듈화 및 표준화

---

## 11. 라벨 프린터 출력 기능 (PDA 앱)

### 11.1 개요
- **프로젝트 경로**: `D:\PDA\PDA-INNO`
- **프린터 제조사**: **Woosim** (우심 프린터)
- **연결 방식**: Bluetooth SPP (Serial Port Profile)
- **출력 방식**: Woosim SDK 명령어 사용 (ZPL 유사)

### 11.2 주요 파일

#### 프린터 연결 및 통신
| 파일 | 역할 |
|------|------|
| [BluetoothPrintService.java](D:\PDA\PDA-INNO\app\src\main\java\com\rgbsolution\highland_emart\print\BluetoothPrintService.java) | Bluetooth 연결 및 데이터 송수신 서비스 |
| [DeviceListActivity.java](D:\PDA\PDA-INNO\app\src\main\java\com\rgbsolution\highland_emart\print\DeviceListActivity.java) | Bluetooth 프린터 검색 및 선택 화면 |

#### 라벨 출력 로직
| 파일 | 역할 |
|------|------|
| [ShipmentActivity.java](D:\PDA\PDA-INNO\app\src\main\java\com\rgbsolution\highland_emart\ShipmentActivity.java) | 배송 라벨 출력 (상품명, 바코드, 중량, 납품일자 등) |
| [ProductionActivity.java](D:\PDA\PDA-INNO\app\src\main\java\com\rgbsolution\highland_emart\ProductionActivity.java) | 생산 라벨 출력 (4라벨 형식) |

### 11.3 BluetoothPrintService 구조

#### 클래스 구성
```java
public class BluetoothPrintService {
    // SPP UUID (표준 시리얼 포트 프로파일)
    private static final UUID SPP_UUID =
        UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    // 연결 상태
    public static final int STATE_NONE = 0;       // 대기
    public static final int STATE_LISTEN = 1;     // 리스닝
    public static final int STATE_CONNECTING = 2; // 연결 중
    public static final int STATE_CONNECTED = 3;  // 연결됨

    // 주요 메서드
    public void connect(BluetoothDevice device, boolean secure)
    public void write(byte[] out)  // 프린터로 데이터 전송
}
```

#### 연결 흐름
```
[PDA 앱]
    ↓
[DeviceListActivity] - 프린터 검색 및 선택
    ↓
[BluetoothPrintService.connect()] - Bluetooth 연결
    ↓
[ConnectThread] - RFCOMM 소켓 연결
    ↓
[ConnectedThread] - 데이터 송수신 스레드
    ↓
[write(byte[])] - Woosim 명령어 전송
    ↓
[Woosim 프린터] - 라벨 출력
```

### 11.4 ShipmentActivity 라벨 출력 코드

#### 사용 라이브러리
```java
import com.woosim.printer.WoosimBarcode;  // 바코드 생성
import com.woosim.printer.WoosimCmd;       // 프린터 명령어
import com.woosim.printer.WoosimImage;     // 이미지/선 그리기
import com.woosim.printer.WoosimService;   // 프린터 서비스
```

#### 라벨 출력 프로세스 (line 1626-1670)

```java
ByteArrayOutputStream byteStream = new ByteArrayOutputStream();

// 1. 프린터 초기화
byteStream.write(WoosimCmd.initPrinter());
byteStream.write(WoosimCmd.setPageMode());
byteStream.write(WoosimCmd.selectTTF("HYWULM.TTF"));  // 한글 폰트
byteStream.write(WoosimCmd.setTextStyle(true, false, false, 1, 1));

// 2. 상품명 출력 (위치: x=50, y=120)
byteStream.write(WoosimCmd.PM_setPosition(50, 120));
if (si.EMARTITEM.length() > 14) {
    byteStream.write(WoosimCmd.getTTFcode(35, 35, si.EMARTITEM + " / " + si.ITEM_SPEC));
} else {
    byteStream.write(WoosimCmd.getTTFcode(40, 40, si.EMARTITEM + " / " + si.ITEM_SPEC));
}

// 3. 바코드 생성 및 출력 (CODE128, 위치: x=50, y=190)
byte[] CODE128 = WoosimBarcode.createBarcode(
    WoosimBarcode.CODE128,  // 바코드 타입
    2,                       // 바 너비
    60,                      // 바코드 높이
    false,                   // HRI (Human Readable Interpretation) 미표시
    pBarcode.getBytes()      // 바코드 데이터
);
byteStream.write(WoosimCmd.PM_setPosition(50, 190));
byteStream.write(CODE128);

// 4. 바코드 번호 (위치: x=45, y=260)
byteStream.write(WoosimCmd.PM_setPosition(45, 260));
byteStream.write(WoosimCmd.getTTFcode(25, 25, pBarcodeStr));

// 5. 중량 정보 (위치: x=50, y=340)
byteStream.write(WoosimCmd.PM_setPosition(50, 340));
byteStream.write(WoosimCmd.getTTFcode(40, 40, "중      량   :   " + weight_str + " KG"));

// 6. 출력 영역 설정 및 프린트
byteStream.write(WoosimCmd.PM_setArea(0, 0, 576, 460));
byteStream.write(WoosimCmd.PM_printData());
byteStream.write(WoosimCmd.PM_setStdMode());

// 7. 프린터로 전송
sendData(byteStream.toByteArray());
sendData(WoosimCmd.feedToMark());  // 라벨 컷 위치까지 이동
```

### 11.5 바코드 타입별 출력 위치 (line 2078-2343)

ShipmentActivity는 **이마트 바코드 타입**에 따라 라벨 레이아웃이 다릅니다:

| 바코드 타입 | 설명 | 특징 |
|------------|------|------|
| **M0** | 일반 매입 | 센터명, 지점명, 상품명, 바코드, 중량, 납품일자, 업체정보 |
| **M1** | 매입 (중앙 배치) | 바코드 위치 조정 (x=145) |
| **M3** | PC매입 | 2개 바코드 (매입용 + 출하용), 소비기한 추가 |
| **M4** | PC매입 (우측) | M3와 유사, 바코드 우측 배치 |
| **M8** | 일반 매입 | M0와 동일 |
| **M9** | 저울 스캔용 | 하단 바코드, 용도표시, CT명 추가 |
| **E0** | 이마트 표준 | M0와 동일 |
| **E1** | 이마트 표준 | M0와 동일 |
| **E2** | 이마트 (조정) | 바코드 위치 조정 (x=90) |
| **E3** | 이마트 (우측) | 바코드 위치 조정 (x=160) |

#### M9 타입 (저울 스캔용) 특수 레이아웃
```java
// 업체명 표시
byteStream.write(WoosimCmd.PM_setPosition(330, 13));
byteStream.write(WoosimCmd.getTTFcode(25, 25, "[(주)하이랜드이노베이션]"));

// 저울스캔용 표시
byteStream.write(WoosimCmd.PM_setPosition(400, 270));
byteStream.write(WoosimCmd.getTTFcode(25, 25, "[저울 스캔용]"));

// 하단 바코드 (위치: x=125, y=325)
byteStream.write(WoosimCmd.PM_setPosition(125, 325));
byteStream.write(LOGISCODE128);

// CT명 (위치: x=450, y=330)
byteStream.write(WoosimCmd.PM_setPosition(450, 330));
byteStream.write(WoosimCmd.getTTFcode(25, 25, si.getCT_NAME()));

// 가로선 그리기
byteStream.write(WoosimImage.drawLine(0, 260, 560, 260, 5));
```

### 11.6 주요 출력 정보

#### 배송 라벨 (ShipmentActivity)
1. **센터명** (CENTERNAME) - 상단
2. **지점명** (CLIENTNAME + STORE_CODE)
3. **상품명** (EMARTITEM)
4. **바코드** - CODE128 형식
   - 포장업체 바코드 (PACKER_PRODUCT_CODE)
   - 물류 바코드 (하단, M3/M4/M9 타입)
5. **중량** (WEIGHT) - "KG" 단위
6. **납품일자** (STORE_IN_DATE) - "YYYY년 MM월 DD일" 형식
7. **업체코드** (PACKER_CODE)
8. **업체명** (PACKERNAME)
9. **소비기한** (EXPIRY_DATE) - M3/M4 타입
10. **창고구역** (WH_AREA) - 우측 하단 대형 폰트 (65pt)

#### 생산 라벨 (ProductionActivity)
- **4라벨 형식**: 한 번에 4개의 라벨 출력 가능
- 데이터 소스: `VW_PDA_WID_PRO_4LABEL_LIST` 뷰

### 11.7 Woosim 명령어 체계

#### 위치 지정
```java
WoosimCmd.PM_setPosition(x, y)  // 좌표 (0,0)는 좌상단
```

#### 텍스트 출력
```java
WoosimCmd.getTTFcode(width, height, text)  // TTF 폰트로 텍스트 출력
WoosimCmd.setTextStyle(bold, italic, underline, widthScale, heightScale)
```

#### 바코드 생성
```java
WoosimBarcode.createBarcode(
    type,       // CODE128, CODE39, EAN13 등
    barWidth,   // 바 너비 (1-4)
    height,     // 바코드 높이 (픽셀)
    showHRI,    // 숫자 표시 여부
    data        // 바코드 데이터 (byte[])
)
```

#### 출력 영역 및 실행
```java
WoosimCmd.PM_setArea(x1, y1, x2, y2)  // 출력 영역 설정
WoosimCmd.PM_printData()              // 프린트 실행
WoosimCmd.feedToMark()                // 라벨 컷 위치까지 용지 이동
```

#### 선 그리기
```java
WoosimImage.drawLine(x1, y1, x2, y2, thickness)  // 직선 그리기
```

### 11.8 프린터 해상도 및 좌표계

- **해상도**: 203 DPI (8 dots/mm)
- **라벨 크기**: 576 x 460 픽셀 (약 72mm x 57mm)
- **좌표계**: 좌상단 (0, 0) 기준
- **폰트 크기**: 25pt ~ 65pt (TTF)
- **한글 폰트**: HYWULM.TTF (내장)

### 11.9 데이터 흐름

```
[서버 JSP]
  ↓ (HTTP)
[PDA 앱 - ShipmentActivity]
  ↓ (데이터 조회)
[상품/배송 정보 로드]
  ↓ (바코드 스캔)
[라벨 출력 트리거]
  ↓ (Woosim 명령어 생성)
[ByteArrayOutputStream]
  ↓ (Bluetooth 전송)
[BluetoothPrintService.write()]
  ↓ (SPP 통신)
[Woosim 프린터]
  ↓
[라벨 출력 완료]
```

### 11.10 주요 특징

1. **실시간 무게 측정 후 즉시 출력**: 상품 무게 입력 후 바로 라벨 프린트
2. **재출력 기능**: 업체명 뒤에 "*" 표시 추가
3. **다양한 바코드 형식 지원**: CODE128 (주로 사용)
4. **소매점별 커스터마이징**: 홈플러스, 롯데, 오노마켓 등
5. **창고 구역 표시**: 대형 폰트로 구역 코드 출력 (WH_AREA)
6. **한글 지원**: TTF 폰트 (HYWULM.TTF) 사용
7. **오류 처리**: Bluetooth 연결 실패/끊김 시 토스트 메시지

### 11.11 Zebra 프린터 관련

**현재 프로젝트에서는 Zebra 프린터를 사용하지 않습니다.**

- ✅ **사용 중**: **Woosim 프린터** (우심)
- ❌ **미사용**: Zebra 프린터 (ZPL 명령어 없음)
- Woosim 프린터는 Zebra와 유사한 모바일 라벨 프린터이지만, 자체 SDK 사용
- ZPL (Zebra Programming Language) 대신 Woosim 전용 명령어 체계 사용

### 11.12 관련 라이브러리

프로젝트에서 사용하는 Woosim SDK는 AAR 파일로 포함되어 있을 것으로 추정:
- `com.woosim.printer.WoosimBarcode`
- `com.woosim.printer.WoosimCmd`
- `com.woosim.printer.WoosimImage`
- `com.woosim.printer.WoosimService`

---

**작성일**: 2025-01-27
**분석 범위**: 디렉토리 구조, insert_goods_wet_homeplus.jsp 상세 분석, Woosim 프린터 라벨 출력 기능
**분석자**: Claude AI
