/*  권한 관리
    - 사용권한 : DBMS는 여러명이 사용
        - 각 사용자 별로 계정을 생성해서 DBMS에 접속할 수 있는 사용자를 생성해 줘야 함.
            ( 인증 (Authentication) : Credential (Identity + PassWord를 합침)
            ( 허가 (Authorization) : 인증된 사용자에게 Oracle의 시스템 권한, 객체 (테이블, 뷰, 트리거, 함거)권한)
                        - System Privileges : 오라클의 전반적인 권한 할당, 테이블 스페이스 내에서 전반적인 권한 (보기-> DBA- > 사용자 -> 편집 -> 시스템권한)
                        - Object Privileges : 테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스 접근 권한
*/

-- Oracle에서 계정 생성 (일반 계정에서는 계정을 생성할 수 있는 권한이 없다.) ->SYS계정으로 접속해야 함 (SYS_9일차_권한관리)

    Create user usertest01 IDENTIFIED by 1234;
    
-- Object Privileges : 테이블 , 뷰 트리거, 함수
    -- 저장 프로시저 , 시퀀스, 인덱스에 부여되는 권한 할당
    ==============================================================
    권한         Table    View    Sequence    Procedure
    ===============================================================
    Alter       0                   0
    Delete      0          0
    Execute                                        0
    Index       0
    Insert      0          0       
    References  0 
    Select      0          0        0
    Update      0          0   
    
    
    
    --------- 특정 테이블에 select 권한 부여하기
       -- ->SYS계정으로 접속해야 함 (SYS_9일차_권한관리) /user_test10 계정만들기