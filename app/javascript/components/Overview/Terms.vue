<template>
  <v-sheet class="mt-3 privacy-part rounded-lg" width="1000px" color="#ffffff" elevation=0>
    <v-row>
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 />
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h2>利用規約</h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        この利用規約（以下，「本規約」といいます。）は、Devio（以下，「当社」といいます。）がこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第1条（個人情報）</h3>
      </v-col>
    </v-row>
    <v-row v-for="(article, index) in chapter_one" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第2条（利用登録）</h3>
      </v-col>
    </v-row>
    <v-row v-for="(article, index) in chapter_two" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ・利用登録の申請に際して虚偽の事項を届け出た場合
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ・本規約に違反したことがある者からの申請である場合
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ・その他，当社が利用登録を相当でないと判断した場合
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第3条（ユーザーIDおよびパスワードの管理）</h3>
      </v-col>
    </v-row>
    <v-row v-for="(article, index) in chapter_three" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第4条（禁止事項）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ユーザーは，本サービスの利用にあたり，以下の行為をしてはなりません。
      </v-col>
    </v-row>
    <v-row dense v-for="(article, index) in chapter_four" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第5条（本サービスの提供の停止等）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        1. 当社は，以下のいずれかの事由があると判断した場合，ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。
      </v-col>
    </v-row>
    <v-row dense v-for="(article, index) in chapter_five" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        2. 当社は，本サービスの提供の停止または中断により，ユーザーまたは第三者が被ったいかなる不利益または損害についても，一切の責任を負わないものとします。
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第6条（利用制限および登録抹消）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        1. 当社は，ユーザーが以下のいずれかに該当する場合には，事前の通知なく，ユーザーに対して，本サービスの全部もしくは一部の利用を制限し，またはユーザーとしての登録を抹消することができるものとします。
      </v-col>
    </v-row>
    <v-row dense v-for="(article, index) in chapter_six" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        2. 当社は，本条に基づき当社が行った行為によりユーザーに生じた損害について，一切の責任を負いません。
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第7条（退会）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ユーザーは，当社の定める退会手続により，本サービスから退会できるものとします。
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第8条（保証の否認および免責事項）</h3>
      </v-col>
    </v-row>
    <v-row v-for="(article, index) in chapter_eight" :key='index'>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        {{article}}
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第9条（サービス内容の変更等）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        当社は，ユーザーに通知することなく，本サービスの内容を変更しまたは本サービスの提供を中止することができるものとし，これによってユーザーに生じた損害について一切の責任を負いません
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第10条（利用規約の変更）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        当社は，必要と判断した場合には，ユーザーに通知することなくいつでも本規約を変更することができるものとします。なお，本規約の変更後，本サービスの利用を開始した場合には，当該ユーザーは変更後の規約に同意したものとみなします。
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第11条（個人情報の取扱い）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        当社は，本サービスの利用によって取得する個人情報については，当社「プライバシーポリシー」に従い適切に取り扱うものとします。
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第12条（通知または連絡）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ユーザーと当社との間の通知または連絡は，当社の定める方法によって行うものとします。当社は,ユーザーから,当社が別途定める方式に従った変更届け出がない限り,現在登録されている連絡先が有効なものとみなして当該連絡先へ通知または連絡を行い,これらは,発信時にユーザーへ到達したものとみなします。
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第13条（権利義務の譲渡の禁止）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        ユーザーは，当社の書面による事前の承諾なく，利用契約上の地位または本規約に基づく権利もしくは義務を第三者に譲渡し，または担保に供することはできません。
      </v-col>
    </v-row>

    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 style="font-weight: bold;">
        <h3>第14条（準拠法・裁判管轄）</h3>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        1. 本規約の解釈にあたっては，日本法を準拠法とします。
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=1 sm=1 md=1 lg=1 xl=1 />
      <v-col cols=10 sm=10 md=10 lg=10 xl=10>
        2. 本サービスに関して紛争が生じた場合には，当社の本店所在地を管轄する裁判所を専属的合意管轄とします。
      </v-col>
    </v-row>
    <v-row>
      <v-col cols=10 sm=10 md=10 lg=10 xl=10 />
    </v-row>
  </v-sheet>
</template>

<script>
  export default {
    name: 'Terms',
    data() {
      return {
        chapter_one: [
          '1. 本規約は，ユーザーと当社との間の本サービスの利用に関わる一切の関係に適用されるものとします。',
          '2. 当社は本サービスに関し，本規約のほか，ご利用にあたってのルール等，各種の定め（以下，「個別規定」といいます。）をすることがあります。これら個別規定はその名称のいかんに関わらず，本規約の一部を構成するものとします。',
          '3. 本規約の規定が前条の個別規定の規定と矛盾する場合には，個別規定において特段の定めなき限り，個別規定の規定が優先されるものとします。'
        ],
        chapter_two: [
          '1. 本サービスにおいては，登録希望者が本規約に同意の上，当社の定める方法によって利用登録を申請し，当社がこれを承認することによって，利用登録が完了するものとします。',
          '2. 当社は，利用登録の申請者に以下の事由があると判断した場合，利用登録の申請を承認しないことがあり，その理由については一切の開示義務を負わないものとします。'
        ],
        chapter_three: [
          '1. ユーザーは，自己の責任において，本サービスのユーザーIDおよびパスワードを適切に管理するものとします。',
          '2. ユーザーは，いかなる場合にも，ユーザーIDおよびパスワードを第三者に譲渡または貸与し，もしくは第三者と共用することはできません。当社は，ユーザーIDとパスワードの組み合わせが登録情報と一致してログインされた場合には，そのユーザーIDを登録しているユーザー自身による利用とみなします。',
          '3. ユーザーID及びパスワードが第三者によって使用されたことによって生じた損害は，当社に故意又は重大な過失がある場合を除き，当社は一切の責任を負わないものとします。'
        ],
        chapter_four: [
          '1. 法令または公序良俗に違反する行為',
          '2. 犯罪行為に関連する行為',
          '3. 本サービスの内容等，本サービスに含まれる著作権，商標権ほか知的財産権を侵害する行為',
          '4. 当社，ほかのユーザー，またはその他第三者のサーバーまたはネットワークの機能を破壊したり，妨害したりする行為',
          '5. 本サービスによって得られた情報を商業的に利用する行為',
          '6. 当社のサービスの運営を妨害するおそれのある行為',
          '7. 不正アクセスをし，またはこれを試みる行為',
          '8. 他のユーザーに関する個人情報等を収集または蓄積する行為',
          '9. 不正な目的を持って本サービスを利用する行為',
          '10. 本サービスの他のユーザーまたはその他の第三者に不利益，損害，不快感を与える行為',
          '11. 他のユーザーに成りすます行為',
          '12. 当社が許諾しない本サービス上での宣伝，広告，勧誘，または営業行為',
          '13. 面識のない異性との出会いを目的とした行為',
          '14. 当社のサービスに関連して，反社会的勢力に対して直接または間接に利益を供与する行為',
          '15. その他，当社が不適切と判断する行為'
        ],
        chapter_five: [
          '・本サービスにかかるコンピュータシステムの保守点検または更新を行う場合',
          '・地震，落雷，火災，停電または天災などの不可抗力により，本サービスの提供が困難となった場合',
          '・コンピュータまたは通信回線等が事故により停止した場合',
          '・その他，当社が本サービスの提供が困難と判断した場合',
        ],
        chapter_six: [
          '・本規約のいずれかの条項に違反した場合',
          '・登録事項に虚偽の事実があることが判明した場合',
          '・料金等の支払債務の不履行があった場合',
          '・当社からの連絡に対し，一定期間返答がない場合',
          '・本サービスについて，最終の利用から一定期間利用がない場合',
          '・その他，当社が本サービスの利用を適当でないと判断した場合'
        ],
        chapter_eight: [
          '1. 当社は，本サービスに事実上または法律上の瑕疵（安全性，信頼性，正確性，完全性，有効性，特定の目的への適合性，セキュリティなどに関する欠陥，エラーやバグ，権利侵害などを含みます。）がないことを明示的にも黙示的にも保証しておりません。',
          '2. 当社は，本サービスに起因してユーザーに生じたあらゆる損害について一切の責任を負いません。ただし，本サービスに関する当社とユーザーとの間の契約（本規約を含みます。）が消費者契約法に定める消費者契約となる場合，この免責規定は適用されません。',
          '3. 前項ただし書に定める場合であっても，当社は，当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害のうち特別な事情から生じた損害（当社またはユーザーが損害発生につき予見し，または予見し得た場合を含みます。）について一切の責任を負いません。また，当社の過失（重過失を除きます。）による債務不履行または不法行為によりユーザーに生じた損害の賠償は，ユーザーから当該損害が発生した月に受領した利用料の額を上限とします。',
          '4. 当社は，本サービスに関して，ユーザーと他のユーザーまたは第三者との間において生じた取引，連絡または紛争等について一切責任を負いません。'
        ]
      }
    }
  }
</script>

<style scoped>
  .privacy-part {
    font-family: 'Roboto, -apple-system, system-ui, "Helvetica Neue", "Segoe UI", "Hiragino Kaku Gothic ProN", "Hiragino Sans", "ヒラギノ角ゴ ProN W3", Arial, メイリオ, Meiryo, sans-serif';
    color: #000000;
    font-weight: 500;
  }
</style>