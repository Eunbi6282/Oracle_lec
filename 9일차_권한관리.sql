/*  권한 관리
    - 사용권한 : DBMS는 여러명이 사용
        - 각 사용자 별로 계정을 생성해서 DBMS에 접속할 수 있는 사용자를 생성해 줘야 함.
            ( 인증 (Authentication) : Credential (Identity + PassWord를 합침)
            ( 허가 (Authorization) : 인증된 사용자에게 Oracle의 시스템 권한, 객체 (테이블, 뷰, 트리거, 함거)권한)
                        - System Privileges : 오라클의 전반적인 권한 할당
                        - Object Privileges : 테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스 접근 권한
*/

-- Oracle에서 계정 생성 (일반 계정에서는 계정을 생성할 수 있는 권한이 없다.)

    Create user usertest01 IDENTIFIED by 1234;


============================================
계정명 : wine_account 
암호 : 1234
기본 테이블 스페이스 : WINE_DATAFILE 100MB ,100MB 무제한 증가 / A하드에 증가
임시 테이블 스페이스 : WINE_LOG 100MB ,100MB씩 최대 1G  증가 / B하드에 증가